/* Приложение состоит из двух страничек note-list - главная страница, 
edit-list - страница изменения заметки, и 5-ти компонентов 
2 выше назвал, диалоговое окно, екземпляр заметки в note-list'e 
и кнопка добавления новой заметки */
<template>
    <div id="app">
        <h1>Test Notes</h1>
        <note-list v-if="noteMode"
                   @start-edit="noteMode = false"/>
        <edit-list v-else
                   @finish-edit="noteMode = true"/>
    </div>
</template>

<script>

    import noteList from './components/test-note-list';
    import editList from './components/test-edit-list';
    export default {
        name: 'App',
        components: {
            noteList,
            editList
        }, 
        data() {
            return {
                noteMode: true
            }
        }
    }
</script>
