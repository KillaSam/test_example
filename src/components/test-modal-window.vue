/* Модальное окно
В зависимости от слота выполяет те или иные действия 
А точнее либо удаляет заметку передая связанное значение через пропсы с одного из родителей
либо выходит из edit-list */

<template>
    <div class="modal-state">
        <div class="modal-window">
            <header class="modal-header">
                <h3>Please confirm your action</h3>  
            </header>
            <article class="modal-text">
                <p id='content'><slot>Are you sure you want to delete this note?</slot></p>
            </article>
            <footer class="modal-footer">
                <button class="cancel-modal" @click="$emit('cancel-conf');">Cancel</button>
                <button class="check-modal" @click="confAction">Submit</button>
            </footer>
        </div>
    </div>
</template>

<script>
export default {
    name: 'modal-window',
    props: {
        numToDel: Number,
        default() {
            return {}
        }
    },
    methods: {
        confAction(){
            // Функция подтверждения действия
            //Проверка содержимого slot и исходя из этого edit-list либо закрывается либо текущая заметка удаляется
            if(document.getElementById('content').textContent==='Are you sure you want to delete this note?'){
                let temp = JSON.parse(localStorage.getItem('lists'));
                temp.splice(this.numToDel-1, 1);
                for(let ind = 0; ind < temp.length; ind++) {
                    temp[ind].numOflist = ind+1;
                } 
                if(temp.length===0){
                    localStorage.removeItem('lists');
                    temp = [{title: '', numOflist: 0, toDo: []}];
                }
                localStorage.setItem('lists', JSON.stringify(temp))
            }
            this.$emit('confAction');
        }
    }
}
</script>