<template>
    <div class="container tasks">
        <ul>
            <li v-for="(task, index) in tasks">
                {{task.title}}
                <i class="fa fa-times" aria-hidden="true"></i>
            </li>
            <li>
                <button class="btn btn-link" type="button">Добавить задачу...</button>
            </li>
        </ul>
    </div>
</template>
<script>
    export default {
        props: {
            tasks: {
                type: Array,
                default() {
                    return [];
                }
            }
        },
        data() {
            return {};
        },
        methods: {

        }
    };
</script>