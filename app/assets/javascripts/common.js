$(document).ready(function(){
  $('.datepicker').datepicker({
    language: 'ja',
    beforeShowDay: function(date) {
      var myDate = new Object();
      if (date.getDay() == 0) {
        myDate.enabled = true;
        myDate.classes = 'class-sunday';
        myDate.tooltip  = '日曜日';
      } else if　(date.getDay() == 6) {
        myDate.enabled = true;
        myDate.classes = 'class-saturday';
        myDate.tooltip  = '土曜日';
      } else {
        myDate.enabled = true;
        myDate.classes = 'class-weekday';
        myDate.tooltip  = '平日';
      }
      return myDate;
    }
  });
});
