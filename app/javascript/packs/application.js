/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')
// Support component names relative to this directory:

import Vue from 'vue/dist/vue'
import Todo from '../components/todo.vue'

document.addEventListener('DOMContentLoaded', () => {
    if(document.getElementById('todo_container')) {
        Vue.component('Todo', Todo);
        const app = new Vue({
            el: '#todo_container',
        })
    }

})