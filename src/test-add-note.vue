/* Кнопка создания заметки
При нажатии вылезает диалоговое окно для ввода имя заметки

*/
<template>
    <div class="add-note">
        <div class="add-info" v-if="isNewNoteInfoVisible">
            <header class="info-header">
                <h3 v-if="!isEmptyArea">Name of a list</h3>
                <h3 v-else>Name should not be empty</h3>
            </header>
            <input id="nameOfTitle" type="text" placeholder="Enter name of a list" />
            <footer class="info-footer">
                <button class="create-new-list" @click="createNewList">
                    <p class="create">Create</p>
                </button>
            </footer>
        </div>
        <div class="add-note-button" 
             @click="isNewNoteInfoVisible = true"
             v-if="!isNewNoteInfoVisible" 
             >
            <i id="note-add" class="material-icons">add</i>
        </div>
        <i id="cancel-create-list" class="material-icons" v-if="isNewNoteInfoVisible" 
                                                          @click="isNewNoteInfoVisible = false;
                                                          isEmptyArea = false;" 
                                                          >clear</i>
    </div>   
</template>

<script>
    
    export default {
        name: 'add-note',
        data() {
            return {
                isNewNoteInfoVisible: false,
                isEmptyArea: false
            }
        },
        methods: {
            createNewList() {
                //Проверка на пустое поле и передача еммита с значением поля
                if(document.getElementById('nameOfTitle').value===''){
                    this.isEmptyArea = true;
                }else{
                    this.isEmptyArea = false;
                    this.$emit('newList', document.getElementById('nameOfTitle').value);
                    this.isNewNoteInfoVisible = false;
                }
            }
        }
    }
</script>
