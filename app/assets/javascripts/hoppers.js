$(document).ready(function () {
  $(".add-task-modal").on('shown.bs.modal', function() {
    $(this).find("[data-focus]").focus();
  });
});
