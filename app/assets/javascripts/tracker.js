$(document).ready(function() {
//    $.cookie.json = true;
    var userUid = '';

    getUUID();

    function postTrackerTracks(myUuid){
        var postData = {track: {uuid: myUuid.uuid, full_path: document.URL, referrer: document.referrer}};
        var postUrl = 'http://tracker.dev:5000/tracks';

        $.ajax({
            type: "POST",
            dataType: 'json',
            contentType: "application/json",
            url: postUrl,
            data: JSON.stringify(postData),
            async: true
        }).done(function(response){
                console.log('we are sending some tracks...');
                console.log(response);
            });
    }

//    function getNewUuid(){
//        var postUrl = 'http://tracker.dev:5000/visitors';
//        var postData = {visitor: true};
//        var postResult = '';
//
//        $.ajax({
//            type: "POST",
//            dataType: 'text json',
//            contentType: "application/json",
//            url: postUrl,
//            data: JSON.stringify(postData),
//            async: false,
//            error: function (xhr, ajaxOptions, thrownError) {
//                alert(xhr.status);
//                alert(thrownError);
//            }
//        }).done(function(response){
//                alert('we got a uuid back');
//                console.log(response);
//                postResult = response.uuid;
//                var payload = {uuid: postResult};
//                makeTrackerCookie(payload);
//            }).always(function(response){
//                alert("second finished");
//            });
//    }

//    function makeTrackerCookie(payload){
//        $.cookie('user_data_follower', payload, {
//            expires: 7,
//            path: '/',
//            domain: 'tracker.dev'
//        });
//    }


    function getUUID(){
        var result = '';
        var url =  "http://user-follower.herokuapp.com/visitors/new.json";
        $.getJSON(url, null, function(response) {
            result = response.uuid;
            postTrackerTracks(result);
        });

    }

});