//= require jquery/dist/jquery.min
//= require jquery-ui
//= require rails-ujs
//= require activestorage
//= require popper.js/dist/umd/popper.min
//= require bootstrap/dist/js/bootstrap.bundle.min
//= require jquery.sticky

function getStatus() {
    Rails.ajax({
        url: '/dashboard/status.json',
        type: 'get',
        success: function(data) {
            $('#projects').html(data.projects);
            $('#tasks').html(data.tasks);
            $('#tasks-waiting').html(data.waiting);
            $('#tasks-review').html(data.review);
            $('#tasks-completed').html(data.completed);
        }
    })
}

$(document).ready(function () {
    getStatus();

    $('.sortable').sortable({
        connectWith: '.content',
        receive: function (event, ui) {
            if (ui.item[0]) {
                let data = ui.item[0].dataset;
                let id = data.taskId;
                let status = $('*[data-task-id='+ data.taskId +']').offsetParent().offsetParent().attr('id');
                Rails.ajax({
                    url: '/tasks/' + id + '/change_status?status=' + status,
                    type: 'get',
                    success: function (data) {
                        getStatus();
                    },
                    error: function (data) {
                    }
                })
            }
        }
    }).disableSelection();

    $('.stick').sticky({topSpacing: 0});
});
