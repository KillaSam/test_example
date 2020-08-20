/* Страница изменнеия заметки
Сделана такой для того чтобы показать что можно для одной страницы использовать один компонент
И если нужно то расширять до 2 и больше, или же нет */

<template>
    <div class="edit-list">
        <modal-window v-if="modalDeleteVisible"
                      :numToDel="this.numOflist"
                      @cancel-conf="modalDeleteVisible = false"
                      @confAction="$emit('finish-edit')"
                      />
        <modal-window v-if="modalEditVisible"
                      @cancel-conf="modalEditVisible = false"
                      @confAction="$emit('finish-edit')"
                      >
            Are you sure you want cancel to edit this note?
        </modal-window>
        <header class="name-of-list">
            <h3>{{title}}</h3>
            <button class="cancel-edit">
                <i  class="material-icons" @click="modalEditVisible = true">clear</i>
            </button>
        </header>
        <div class="actions">
            <button class="add-toDo-point" @click="toDo.push({name: '', isCheck: false}); saveNote()">
                <i  class="material-icons">add_task</i>
                <p>Add task</p>
            </button>
            <button class="sub-toDo-point" @click="toDo.pop(); saveNote()">
                <i  class="material-icons">indeterminate_check_box</i>
                <p>Delete task</p>
            </button>
             <button class="save-changes" @click="saveChanges">
                <i  class="material-icons">save_alt</i>
                <p>Save changes</p>
            </button>
            <button class="delete-button" @click="modalDeleteVisible = true">
                <i  class="material-icons">delete</i>
                <p>Delete note</p>
            </button>
            <button class="cancel-edition" @click="undo">
                <i  class="material-icons">undo</i>
                <p>Undo</p>
            </button>
            <button class="reply-cancel-edit" @click="redo">
                <i  class="material-icons">redo</i>
                <p>Redo</p>
            </button>
        </div>
        <div class="toDO-list">
            <ul v-for="(check, x ) in toDo" :key="x">
                <li class="checkbox">
                    <input class="my-checkbox" type="checkbox" :id="x" :name="x" 
                                                               :checked="check.isCheck" 
                                                               @change="changeCheckBox">
                    <label :for="x">
                    </label>
                    <input type="text" class="toDo-point" placeholder="Please enter your task" 
                                                          :id="x" 
                                                          :value="check.name" 
                                                          @input="changeTask">
                </li>
            </ul>
        </div>
        <footer class="bottom"></footer>
    </div>
</template>

<script>
import modalWindow from './test-modal-window'
export default {
    name: 'edit-list',
    components: {
        modalWindow
    },
    data() {
        return {
            title: '',
            numOflist: 0,
            toDo: [],
            modalDeleteVisible: false,
            modalEditVisible: false
        }
    },
    mounted() {
        if(localStorage.getItem('currList')){
            let tempList = JSON.parse(localStorage.getItem('currList'));
            this.title = tempList.title;
            this.numOflist = tempList.numOflist;
            this.toDo = tempList.toDo;
        }
    },
    methods: {
        saveNote(){
            localStorage.setItem('currList', JSON.stringify({title: this.title, numOflist: this.numOflist, toDo: this.toDo}));
        },
        changeTask(e){
            this.toDo[e.target.id].name = e.target.value;
            this.saveNote();
        },
        changeCheckBox(e){
            this.toDo[e.target.id].isCheck = e.target.checked;
            this.saveNote();
        },
        saveChanges(){
            let temp = JSON.parse(localStorage.getItem('lists'));
            temp.splice(this.numOflist-1, 1, {title: this.title, numOflist: this.numOflist, toDo: this.toDo});
            localStorage.setItem('lists', JSON.stringify(temp));
            this.$emit('finish-edit');
        },
        undo(){
            localStorage.setItem('bufferList', JSON.stringify({title: this.title, numOflist: this.numOflist, toDo: this.toDo}));
            this.toDo = JSON.parse(localStorage.getItem('lists'))[this.numOflist-1].toDo;
            localStorage.setItem('currList', JSON.stringify({title: this.title, numOflist: this.numOflist, toDo: this.toDo}));
        },
        redo(){
            if(localStorage.getItem('bufferList')){
                this.toDo = JSON.parse(localStorage.getItem('bufferList')).toDo;
                localStorage.removeItem('bufferList');
            }
        }
    }
}
</script>

