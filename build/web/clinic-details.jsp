<!DOCTYPE html>
<html lang="en">


    <!-- blog23:34-->
    <head>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
        <title>PHR - Manage Personal Health Record</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/customStyle.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <style>
            body{
                font-size: 14px;
            }
            .sidebar-menu li a {
                color: black;
                font-weight: 500;
            }

            .sidebar-menu li#aClinic a {
                color: #009efb;
                /*background-color: #2a9c31;*/
                background-color: #e3e7e8;
            }
            i.fa.fa-bars{
                padding-top: 14px;
            }

            .custom-seach{
                border-radius: 15px;
                width: 35% !important;
                height: 35px;
                font-size: 16px;

            }
            .btn-primary{
                width: 105px;
                height: 30px;
                font-size: 14px;
            }
            .custom-btn{
                width: 80px;
                height: 35px;
                font-size: 14px;
            }
            div.blog-content{
                font-size: 16px;
            }
            #clinicDescription{
                margin-left: 25px;
            }
            .blog-view{
                width: 150%;
            }
            .fa.fa-star.checked {
                color: yellow;
            }
            .fa.fa-star{
                color:gray;
            }
            .checked1 {

                background: linear-gradient(to left, gray 50%, yellow 50%);
                background-clip: text;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;


            }
            .fa.fa-trash-o.m-r-5{
                cursor: pointer;
            }
        </style>
    </head>

    <%@include file="components/header.html" %>
    <%@include file="components/sidebar.html" %>
    <div class="page-wrapper">
        <div class="content">
            <div class="row">
                <div class="col-sm-12">
                    <h4 class="page-title">Clinic's Information</h4>
                </div>
            </div>
            <div class="row">
                <div class="col-md-8">
                    <div class="blog-view">
                        <article class="blog blog-single-post">
                            <h3 id="clinicTitle" class="blog-title"></h3>
                            <div class="blog-info clearfix">
                                <div class="post-left">
<!--                                    <ul>
                                        <li><a href="#."><i class="fa fa-user-o"></i> By <span id="userAdd"></span></a></li>
                                    </ul>-->
                                </div>
<!--                                <div class="post-right"><a href="#."><i  class="fa fa-comment-o"></i><span id="icomments"></span></a></div>-->
                            </div>
                            <div class="blog-image">
                                <a href="#."><img id="clinicImg" alt="" src="" class="img-fluid"></a>
                            </div>
                            <div class="blog-content">

                                <div>
                                    Địa chỉ: <span id="clinicAddress"></span>
                                </div>
                                <div>
                                    Quận: <span id="clinicDistrict"></span>
                                </div>
                                <div>
                                    Điện thoại: <span id="clinicPhone"></span>
                                </div>
                                <div>
                                    Thời gian làm việc: <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+Thứ hai đến thứ bảy: 7:30 – 19:30.
                                    <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+Chủ nhật: 7:30 – 11:30.
                                    <br/>
                                    <br/>
                                </div>

                                <div>
                                    Giới thiệu: <br/> <span id="clinicDescription"></span>
                                </div>

                            </div>
                        </article>
                        <div id='rating' class="widget blog-share clearfix">
                            <h3>Rating</h3>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                        </div>

                        <div class="widget blog-comments clearfix">
                            <h3>Comments (<span id="comments">0</span>) </h3> 
                            <ul id='listComment' class="comments-list">
                                <li>
                                    <div class="comment">
                                        <div class="comment-author">
                                            <!--<img class="avatar" alt="" src="assets/img/user.jpg">-->
                                        </div>
                                        <div class="comment-block">
                                            <span class="comment-by">
                                                <span class="blog-author-name"></span>
                                            </span>
                                            <p></p>
                                            <span class="blog-date"></span>
                                        </div>
                                        <div hidden="">
                                            <button class="clss-commnet">Block</button>
                                        </div>
                                    </div>                                    
                                </li>
                            </ul>
                        </div>

                    </div>
                </div>

            </div>
        </div>
        <%@include file="components/footer.html" %>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/app.js"></script>
        <script>
            

        </script>
        <script  type="text/javascript">
            var token = sessionStorage.getItem("key");
            
            window.onload = function () {
                
                var clinicID = JSON.parse(localStorage.getItem("clinicID"));
                console.log(clinicID +" id");
               var rating = JSON.parse(sessionStorage.getItem("rating"));
               console.log(" Tổng số lần rate" + rating.length);
                
                
                $.ajax({
                   type: "GET",
                   dataType: "json",
                   contentType: "application/json",
                       headers: {
                       Authorization: 'Bearer ' + token},
                   url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/clinics/clinic/" +clinicID,
//                                                        
                    success: function (data) { 
                        $('#clinicImg').attr('src', data.image);
                        document.getElementById("clinicTitle").innerHTML = data.name;
                        document.getElementById("clinicAddress").innerHTML = data.address;
                        document.getElementById("clinicDistrict").innerHTML = data.district;
                        document.getElementById("clinicPhone").innerHTML = data.phone;
                        if (!data.description) {
                            document.getElementById("clinicDescription").innerHTML = "..."

                        } else {
                            document.getElementById("clinicDescription").innerHTML = data.description;
                        }
                      $.ajax({
                   type: "GET",
                   dataType: "json",
                   contentType: "application/json",
                       headers: {
                       Authorization: 'Bearer ' + token},
                   url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/ratings/ratings/" +clinicID,
//                                                        
                    success: function (value) { 
                        
                        console.log(value);
                        
                        var x = "";
                        var y = "";
                        var count = 0
                        for (var i = 0; i < rating.length; i++) {
                            count += rating[i].rate;
                        }
                        count = count / rating.length;
                        console.log(count);
                        if (Number.isNaN(count)) {
                            console.log(Number.isNaN(count));
                            count = 0;
                        }
                        if (count < 0.5) {
                            x = '<h3>Rating</h3><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 0.5 && count < 1) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked1"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 1 && count < 1.5) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 1.5 && count < 2) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked1"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 2 && count < 2.5) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 2.5 && count < 3) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked1"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 3 && count < 3.5) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star"></span><span class="fa fa-star"></span>';
                        } else if (count > 3.5 && count < 4) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked1"></span><span class="fa fa-star"></span>';
                        } else if (count > 4 && count < 4.5) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star"></span>';
                        } else if (count > 4.5 && count < 5) {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked1"></span>';
                        } else {
                            x = '<h3>Rating</h3><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span><span class="fa fa-star checked"></span>';
                        }
                        for (var j = 0; j < rating.length; j++) {
                            var time = rating[j].time.split("T");
                            y += '<li><div class="comment"><div class="comment-author">'
                                    + '<img class="avatar" alt="" src=' + rating[j].image + '></div>'
                                    + '<div class="comment-block"><span class="comment-by">'
                                    + '<span class="blog-author-name">' + rating[j].name + '</span>&nbsp &nbsp<span onclick="disableComment('+ rating[j].id +')"><i class = "fa fa-trash-o m-r-5" ></i></span></span>'
                                    + '<p>' + rating[j].comment + '</p>'
                                    + '<span class="blog-date">' + time[0] + '</span></div></div></li>';
                        }
                        $("#rating").html(x);
                        $("#comments").html(rating.length);
                        $("#icomments").html(rating.length);
                        $("#listComment").html(y);
                
//                document.getElementById("userAdd").innerHTML = data.username;
                
                  }});
                
                
                }});
            }
            function disableComment(id) {
            
               $.ajax({
                    type: "PUT",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    headers: {Authorization: 'Bearer ' + token},
                    beforeSend:function(){
                             return confirm("Are you sure?");
                     },
                    url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/ratings/rating/" + id + "?status=disable",
                    complete: function (jqXHR) {
                        window.location.href = "clinic-details.jsp";
                    }
                });
            };
        </script>

    </body>


    <!-- blog-details23:56-->
</html>