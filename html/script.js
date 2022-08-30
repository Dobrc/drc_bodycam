$(function () {
    $(document).ready(function() {
        window.addEventListener('message', function(event) {    
            switch(event.data.action) {
                case "update":
                    $('#name').html("AXON BODY | " + event.data.name  );
                    $('#time').html(event.data.date);
                    $('#job').html(event.data.job);   
                    break;
                case "loadui":
                    $(".container").show();    
                    var top = localStorage.top + 'px';
                    var left = localStorage.left + 'px';
   
                    $('.container').css({
                        position:'absolute',
                        top:top,
                        left:left
                    });
                    
                    $(".container").draggable({
                        scroll: false,
                        axis: "x, y",
                        cursor: "move",
                        containment: "window"
                    });
                    
                    break;
                
                case "closeui":
                    $(".container").hide();
                    break;
                
                default:
            };
        });
    });
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            var x = $(".container").position();
            localStorage.top = x.top;
            localStorage.left = x.left;
            $('.container').css({
                position:'absolute',
                top:x.top,
                left:x.left
            });
            
            $.post('https://drc_bodycam/exit', JSON.stringify({}));
            return;
        }
    };
})