/*Компонент екземпляра заметки
Данные передаются с note-list*/

<template>
    <transition name="slide-fade">
        <div class="note-wrapper" v-if="lists_data.title">
            <header class="note-header">
                <h3 class="name-of-list">{{lists_data.title}}</h3>
                <i id="edit" class="material-icons" @click="goToEditMenu">edit</i>
            </header>
            <ul class="notes" >
                <li v-for="(toDoProp, x) in lists_data.toDo" :key="x">
                    <input class="my-checkbox" type="checkbox" :id="x" :name="x" 
                                           :checked="toDoProp.isCheck" 
                                            disabled>
                    <label :for="x" ></label>
                    <span :id="x" class="name-of-note">{{toDoProp.name}}</span>
                </li>
            </ul>
            <footer class="note-footer">
                <i id="delete-icon" class="material-icons" @click="$emit('conf-delete-list', lists_data.numOflist)">delete</i>
            </footer>
        </div>
    </transition>
</template>

<script>
    export default {
        name: 'note-wrapper',
        props: {
            lists_data: {
                type: Object,
                default (){
                    return {};
                }
            }
        },
        methods: {
            goToEditMenu(){
                //Переход в edit-list, сохранение текущей заметки для последующего отображения
                this.$emit('goToEdit');
                localStorage.setItem('currList', JSON.stringify(this.lists_data));
                localStorage.removeItem('bufferList');
            }
        }
    }
</script>