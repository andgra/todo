<template>
    <div class="tasks">
        <div class="tasks-list">
            <div class="tasks-list-item" v-for="(task, index) in items" :data-id="index" @click="editItem">
                <input type="hidden" v-model="task.id">
                <span v-if="edit==index">
                    <textarea type="text" class="form-control" v-model="task.title"></textarea>
                </span>
                <span v-else>
                    <input type="checkbox" v-model="task.done" @change="saveItem(index)">
                    <span :class="{'tasks-list-item-title': true, done: task.done}">
                        {{task.title}}
                    </span>
                    <span class="tasks-list-item-controls">
                        <i class="fa fa-caret-square-o-up" @click="moveUp(index)" v-if="index>0" aria-hidden="true"></i>
                        <i class="fa fa-caret-square-o-down" @click="moveDown(index)" v-if="index<items.length-1" aria-hidden="true"></i>
                        <i class="fa fa-times" @click="removeItem(index)" aria-hidden="true"></i>
                    </span>
                </span>
            </div>
        </div>
        <div class="tasks-add">
            <button class="btn btn-link" type="button" @click="addItem()">Добавить задачу...</button>
        </div>
    </div>
</template>
<script>
    let taskSeed = {
        id: "",
        title: "",
        done: 0
    };
    export default {
        props: {
            tasks: {
                type: Array,
                default() {
                    return [];
                }
            },
            ajax_url: {
                type: String,
                default() {
                    return "";
                }
            },
            list_id: {
                type: Number,
                default() {
                    return 0;
                }
            }
        },
        data() {
            return {
                items: JSON.parse(JSON.stringify(this.tasks.sort((t1, t2) => { return t1.sort>t2.sort }))),
                edit: -1
            };
        },
        methods: {
            moveUp(index) {
                if(index>0) {
                    let toUp = this.items[index];
                    this.items.splice(index, 1);
                    this.items.splice(index - 1, 0, toUp);
                    this.saveItem(index - 1);
                    this.saveItem(index);
                }
            },
            moveDown(index) {
                if(index<this.items.length-1) {
                    let toDown = this.items[index];
                    this.items.splice(index, 1);
                    this.items.splice(index + 1, 0, toDown);
                    this.saveItem(index + 1);
                    this.saveItem(index);
                }
            },
            editItem(e) {
                let $target = $(e.target);
                let $item;
                if($target.hasClass('tasks-list-item')) {
                    $item = $target;
                } else if ($target.hasClass('tasks-list-item-title')) {
                    $item = $target.parents('.tasks-list-item');
                }
                if($item) {
                    let index = $item.data('id');
                    this.edit = index;
                }
            },
            removeItem(index) {
                let task = this.items[index];
                if(task.id) {
                    $.ajax({
                        type: "POST",
                        url: this.ajax_url,
                        data: {
                            type: 'del',
                            task_id: task.id,
                        },
                        dataType: 'json'
                    });
                }
                this.items.splice(index, 1);
            },
            addItem() {
                this.items.splice(this.items.length, 1, JSON.parse(JSON.stringify(taskSeed)));
                this.edit = this.items.length - 1;
            },
            saveItem(index) {
                let task = this.items[index];
                task.sort = index+1;
                if(task.id) {
                    $.ajax({
                        type: "POST",
                        url: this.ajax_url,
                        data: {
                            type: 'edit',
                            task: task,
                        },
                        dataType: 'json'
                    });
                } else {
                    $.ajax({
                        type: "POST",
                        url: this.ajax_url,
                        data: {
                            type: 'add',
                            task: task,
                            list_id: this.list_id
                        },
                        success: function(data) {
                            if(data.code) {
                                task.id = data.text;
                            }
                        },
                        dataType: 'json'
                    });
                }
            }
        },
        mounted() {
            $(document.body).on('click', $.proxy(function (e) {
                let $target = $(e.target);
                if (!$target.parents('.tasks-list-item').length
                    && !$target.hasClass('tasks-list-item')
                    && !$target.parents('.tasks-add').length) {
                    this.edit = -1;
                }
            }, this));
            this.$watch('edit',(newVal, oldVal) => {
                if(oldVal!==-1 && this.items[oldVal]) {
                    if (!this.items[oldVal].title) {
                        this.removeItem(oldVal);
                        this.edit -= 1;
                    } else {
                        this.saveItem(oldVal);
                    }
                }
            });
        }
    };
</script>