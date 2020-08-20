/* Главная страница
Появляется по дефолту при загрузки приложения
В ней все заметки которые хранит localStorage
Диалоговое окно которое появляется при попытке удаления заметки
И кнопка добавления заметки */


<template>
    <div class="note-list">
        <note-wrapper  v-for="list in this.lists" 
                       :key="list.numOflist" 
                       :lists_data="list" 
                       @conf-delete-list="confToDelList"
                       @goToEdit="$emit('start-edit')"
                       />
        <add-note @newList="createNewList"/>
        <modal-window v-if="modalVisible" 
                      :numToDel="numToDelete"
                      @cancel-conf="numToDelete = 0; modalVisible = false"
                      @confAction="afterDelete"
                      />
    </div>
</template>

<script>
    import modalWindow from './test-modal-window';
    import noteWrapper from './test-note-wrapper'
    import addNote from './test-add-note'
    export default {
        name: 'note-list',
        props:{},
        components: {
            modalWindow,
            noteWrapper,
            addNote
        },
        data() {
            // В данных компонента массив заметок, определитель видимости диалогового окна 
            // и номер заметки который передается дочернему компоненту для удаления
            return {
                lists: [
                    {
                        title: '',
                        numOflist: 0,
                        toDo: []
                    }
                ],
                modalVisible: false,
                numToDelete: 0
            }
        },
        mounted() {
            if(localStorage.getItem('lists')){
                this.lists = JSON.parse(localStorage.getItem('lists'));
            }
        },
        methods: {
            createNewList(newTitle){
                //Проверка, добавление объекта и сортировка массива list
                if(typeof this.lists.numOflist === 'undefined'){
                    this.lists.push({ title: newTitle, numOflist: 0, toDo: []})
                    this.lists[this.lists.length-1].numOflist = this.lists.length-1;
                } 

                if(this.lists[0].numOflist===0 && this.lists[0].title===''){
                    this.lists.shift();
                }
                
                for(let ind = 0; ind < this.lists.length; ind++) {
                    this.lists[ind].numOflist = ind+1;
                } 
                
                this.saveLists();
            },
            saveLists() {
                //Метод чтобы часто эту длинную строчку не писать несколько раз
                localStorage.setItem('lists', JSON.stringify(this.lists));
            },
            
            confToDelList(num) {
                //Подтверждение удаления елемента и отправка модальному окну порядкового номера для удаления
                this.numToDelete = num;
                this.modalVisible = true;
            },
            afterDelete(){
                //Возвращение к дефолтному состоянию компонента перед удалением заметки
                this.modalVisible = false;
                this.numToDelete = 0;
                this.lists = JSON.parse(localStorage.getItem('lists'));
            }
        }
    }
</script>
