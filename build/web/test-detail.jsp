<!DOCTYPE html>
<html lang="en">
    <head>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">

        <link rel="shortcut icon" type="image/x-icon" href="assets/img/logo-dark.png">
        <title>PHR - Manage Personal Health Record</title>
        <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="assets/css/style.css">
        <link rel="stylesheet" type="text/css" href="assets/css/customStyle.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <style>
            .sidebar-menu li a {
                color: black;
                font-weight: 500;
            }

            .sidebar-menu li#aTest a {
                color: #009efb;
                /*background-color: #2a9c31;*/
                background-color: #e3e7e8;
            }
            table, th, td {
                border: 3px solid black;
                text-align: center;
            }
            thead {
                text-align: center;
                color: #009efb;
                font-weight: bolder;
            }
            .close{
                margin-right: 40%;
                transform: scale(1.2);
                -ms-transform: scale(1.2);
                -webkit-transform: scale(1.2);
                opacity: 0.85;
                font-weight: 500;
                color: red;

            }
            .close:hover{
                opacity: 1;
                color: orangered;
            }

            caption{
                color: #000;
                font-size: 18px;
                font-weight: bold;

            }
            .testPackage{
                left: 12%;
            }
            
            .divPrice{
                float: right;
            }
            button#buttonAdd.btn.btn.btn-primary{
                position: relative;
                left: 300px;
            }
            h3#packageName.blog-title{
                position: relative;
                left: 200px;
            }
            div.col-md-12.testtables{
                position: relative;
                left: -90px;
            }
            div.col-sm-3.col-3{
                position: relative; 
                left:590px;
                top: 80px;
                margin-bottom: 10px;
                z-index: 10;
            }
           
        </style>
    </head>

    <%@include file="components/header.html" %>
    <%@include file="components/sidebar.html" %>
    <div class="page-wrapper">
        <div class="content">
            <div class="form-group row">
                <div class="col-sm-3 col-3"></div>
                 <div class="col-sm-3 col-3">
                     <label><h4>Type</h4></label>
                     <select>
                         <option value="adult">Adult</option>
                         <option value="children">Children</option>
                     </select>
                </div>
                
                    <div class="addButton">
                        <button id="buttonAdd" class="btn btn btn-primary"><i class="fa fa-plus"></i> Add Text Indexes to Package</button>
                    </div>
                
            </div>
            <div class="row">
                <div class="col-md-12 testtables">
                    <h3 id="packageName" class="blog-title"></h3>
                    <span id='messageName'></span>
                    <div id="hiddenWall" class="col-10 testPackage table-responsive">                        
                        <table id="testPackageTable" class="table table-bordered datatable mb-0">
                            <thead>
                                <tr>
                                    <th style="width: 20%">Name</th>
                                    <th style="width: 15%">Male</th>
                                    <th style="width: 15%">Female</th>
                                    <th style="width: 15%">Price</th>
                                    <th style="width: 10%">Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="name"></td>
                                    <td id="male"></td>
                                    <td id="female"></td>
                                    <td id="price"></td>
                                    <td id="delete"></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="col-sm-3 divPrice">
                            <div class="form-group">
                                <label><span class="text-danger">Price </span></label>
                                <input class="form-control inputValue clss-input-price" id='price' name="price" type="number" step=".01" value="0" readonly>
                                <span id='messageChildMin'></span>
                            </div>
                        </div>                        
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay"></div>
        <%@include file="components/footer.html" %>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/moment.min.js"></script>
        <script src="assets/js/bootstrap-datetimepicker.min.js"></script>
        <script src="assets/js/app.js"></script>
        <script type="text/javascript">
            var testId = [];
            var count = 0;
            var checkPackage = [];
            var dataPackage = "";
            //==============================Loading Page=========================================
            $(document).ajaxStart(function () {
                $("div").addClass("loading");
            });
            $(document).ajaxStop(function () {
                $("div").removeClass("loading");

                if (testId.length === 0) {
                    $("#buttonAdd").show();
                    $("button[id='buttonX']").removeAttr('disabled');
                }
                console.log(testId);
//                console.log(typeof(testId));
                if(testId === 0){
                $('#hiddenWall').addClass('error');
                 document.getElementById("hiddenWall").style.display = "none";
                 document.getElementById('messageName').style.color = 'green';
                 document.getElementById('messageName').innerHTML = 'NO TEST IN THIS PACKAGE YET';
                 }
            });
            
                
            $('select').on('change', function() {
                var _type = $(this).val();
                var packageName = sessionStorage.getItem("packageName");
                document.getElementById("packageName").innerHTML = packageName;
                $("#buttonAdd").show();
                $("button[id='buttonX']").removeAttr('disabled');
                localStorage.setItem("testName", "");
                var token = sessionStorage.getItem("key");
                var dataPackage = JSON.parse(localStorage.getItem("dataPackage"));
                var valueArray = [];
                var arrayTotal = [];
                var testName = [];
                console.log(valueArray);
                $.ajax({
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json; charset=UTF-8",
                    headers: { Authorization: 'Bearer ' + token},
                    url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-detail/" + dataPackage.id,
                    success: function (data) {
                        var a = JSON.stringify(data);
                        var b = JSON.parse(a);
                        for (var i = 0; i < data.length; i++) {
                            $.ajax({
                                type: "GET",
                                dataType: "json",
                                contentType: "application/json; charset=UTF-8",
                                headers: {
                                    Authorization: 'Bearer ' + token},
                                url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-detail/" +dataPackage.id,
                                success: function (data) {
                                var mainData = [];
                                console.log(data);
                                data.forEach(element => {
                                    var dataShow = new Object();
                                    dataShow.name = element.name;
                                    dataShow.price = element.price;
                                    dataShow.description = element.description;
                                    dataShow.maleIndex = '-';
                                    dataShow.femaleindex = '-';
                                    dataShow.childIndex = '-';                                    
                                    element.samplelst.forEach(e => {
                                        if (_type === "adult") {
                                            if (e.type === 'Male' || e.type === 'male') {
                                                dataShow.maleIndex = e.indexValueMin + '-' + e.indexValueMax;
                                            } else if (e.type === 'Female' || e.type === 'female') {
                                                dataShow.femaleindex = e.indexValueMin + '-' + e.indexValueMax;
                                            }
                                        }
                                        else {
                                            if (e.type === 'Child-Male') {
                                                dataShow.maleIndex = e.indexValueMin + '-' + e.indexValueMax;
                                            }else if (e.type === 'Child-Female') {
                                                dataShow.femaleindex = e.indexValueMin + '-' + e.indexValueMax;
                                            }
                                        }
                                    });
                                    mainData.push(dataShow);
                                });
                                
                                localStorage.setItem("testName", testName);
//                                $('#testPackageTable').append('<caption style="caption-side: top">' + dataPackage.name + '</caption>');
                                $('#testPackageTable').DataTable({                                    
                                data: mainData,
                                columns: [
                                    { data: 'name',},
                                    {
                                        data: 'maleIndex',
                                        render: function (data, type, row, meta) {
                                            if ( row.maleIndex === '-9999--9999') {
                                                return "Âm tính";
                                            }else{
                                                return row.maleIndex;
                                            }
                                        }
                                    },
                                    {
                                        data: 'femaleindex',
                                        render: function (data, type, row, meta) {
                                            if ( row.femaleindex === '-9999--9999') {
                                                return "Âm tính";
                                            }else{
                                                return row.femaleindex;
                                            }
                                        }
                                    },
                                    {
                                        data: 'price'
                                        
                                    },
                                    {
                                        defaultContent: '<td id="actionIcon" class="close"><button id="buttonX" type="button" class="close" aria-label="Close"><span class="deleteButton" aria-hidden="true">&times;</span></button></td>'
                                    }
                                    ],
                                    "bDestroy": true,
                                    "bFilter": false,
                                    "aaSorting": [],
                                    "bPaginate": false,
                                    "bSort": false,
                                    "bInfo": false,
                                });
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    console.log(' Error in processing! ' + textStatus);
                                }
                            })
                        }
//                        $('#testPackageTable tbody').on('click', 'button', function () {
//                            var tr = $(this).closest("tr");
//                            var rowindex = tr.index();
//                            table = document.getElementById("testPackageTable");
//                            tr = table.getElementsByTagName("tr");
//                            td = tr[rowindex + 1].getElementsByTagName("td")[0];
//                            txtValue = td.textContent;
//                            for (var i = 0; i < data.length; i++) {
//                                if (data[i].name === txtValue) {
//                                    $.ajax({
//                                        type: "DELETE",
//                                        dataType: "json",
//                                        contentType: "application/json; charset=utf-8",
//                                        headers: {
//                                            Authorization: 'Bearer ' + token},
//                                        beforeSend:function(){
//                                                return confirm("Are you sure?");
//                                             },
//                                        url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-test/" + dataPackage.id + "/" + data[i].id,
//                                        complete: function (jqXHR) {
//                                            window.location.href = "test-detail.jsp";
//                                        }
//                                    });
//                                }
//                            }
//                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(' Error in processing! ' + textStatus);
                    },
                })     
            });
            
            $('#buttonAdd').click(function (event) {
                var ids = dataPackage.id;
                var listTestDouple = [];
                $.ajax({
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json; charset=UTF-8",
                    headers: {
                         Authorization: 'Bearer ' + token
//                        'Access-Control-Allow-Origin': '*'
                    },
                    url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-detail/" + dataPackage.id,
                    success: function (data) {
                        console.log(data);
                        for (var i = 0; i < data.length; i++) {
                            let id = data[i].id.toString();
//                            console.log(typeof (id));
                            for (var j = 0; j < listTestId.length; j++) {
//                                console.log(listTestId[j]);
                                if (id === listTestId[j]) {
                                    listTestDouple.push(j);
                                }
                            }
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(' Error in processing! ' + textStatus);
                    }
                });
                sessionStorage.setItem('packageId', dataPackage.id);
                window.location.href = "add-TestToPackage.jsp";
            });
            
            window.onload = function () {
                var packageName = sessionStorage.getItem("packageName");
                document.getElementById("packageName").innerHTML = packageName;
                $("#buttonAdd").show();
                $("button[id='buttonX']").removeAttr('disabled');
                localStorage.setItem("testName", "");
                var token = sessionStorage.getItem("key");
                dataPackage = JSON.parse(localStorage.getItem("dataPackage"));
                var valueArray = [];
                var arrayTotal = [];
                var testName = [];
                var _totalPrice = 0;
                console.log(valueArray);
                $.ajax({
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json; charset=UTF-8",
                    headers: { Authorization: 'Bearer ' + token},
                    url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-detail/" + dataPackage.id,
                    success: function (data) {
                        var a = JSON.stringify(data);
                        var b = JSON.parse(a);
                        var mainData = [];
                        $.ajax({
                            type: "GET",
                            dataType: "json",
                            contentType: "application/json; charset=UTF-8",
                            headers: {
                                Authorization: 'Bearer ' + token},
                            url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-detail/" +dataPackage.id,
                            success: function (data) {
                            console.log(data);
                            data.forEach(element => {
                                var dataShow = new Object();
                                dataShow.name = element.name;
                                dataShow.price = element.price;
                                dataShow.description = element.description;
                                dataShow.maleIndex = '-';
                                dataShow.femaleindex = '-';
                                dataShow.childIndex = '-';                                    
                                element.samplelst.forEach(e => {
                                    if (e.type === 'Male' || e.type === 'male') {
                                        dataShow.maleIndex = e.indexValueMin + '-' + e.indexValueMax;
                                    } else if (e.type === 'Female' || e.type === 'female') {
                                        dataShow.femaleindex = e.indexValueMin + '-' + e.indexValueMax;
                                    } 
                                });
                                _totalPrice = _totalPrice + parseFloat(element.price);
                                mainData.push(dataShow);
                            });
                            $('.clss-input-price').val(_totalPrice).trigger('change');
                            localStorage.setItem("testName", testName);
//                                $('#testPackageTable').append('<caption style="caption-side: top">' + dataPackage.name + '</caption>');
                            $('#testPackageTable').DataTable({                                    
                            data: mainData,
                            columns: [
                                { data: 'name',},
                                {
                                    data: 'maleIndex',
                                    render: function (data, type, row, meta) {
                                        if ( row.maleIndex === '-9999--9999') {
                                            return "Âm tính";
                                        }else{
                                            return row.maleIndex;
                                        }
                                    }
                                },
                                {
                                    data: 'femaleindex',
                                    render: function (data, type, row, meta) {
                                        if ( row.femaleindex === '-9999--9999') {
                                            return "Âm tính";
                                        }else{
                                            return row.femaleindex;
                                        }
                                    }
                                },
                                {
                                    data: 'price'
                                   
                                },
                                {
                                    defaultContent: '<td id="actionIcon" class="close"><button id="buttonX" type="button" class="close" aria-label="Close"><span class="deleteButton" aria-hidden="true">&times;</span></button></td>'
                                }
                            ],
                            "bDestroy": true,
                            "bFilter": false,
                            "aaSorting": [],
                            "bPaginate": false,
                            "bSort": false,
                            "bInfo": false,
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(' Error in processing! ' + textStatus);
                    }
                })
                $('#testPackageTable tbody').on('click', 'button', function () {

                    var tr = $(this).closest("tr");
                    var rowindex = tr.index();
                    table = document.getElementById("testPackageTable");
                    tr = table.getElementsByTagName("tr");
                    td = tr[rowindex + 1].getElementsByTagName("td")[0];
                    txtValue = td.textContent;
                    for (var i = 0; i < data.length; i++) {
                        if (data[i].name === txtValue) {

                            $.ajax({
                                type: "DELETE",
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                headers: {
                                    Authorization: 'Bearer ' + token},
                                beforeSend:function(){
                                        return confirm("Are you sure?");
                                     },
                                url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/package-tests/package-test/" + dataPackage.id + "/" + data[i].id,
                                complete: function (jqXHR) {

                                    window.location.href = "test-detail.jsp";

                                }
                            });
                        }
                    }
                });  
            },   
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(' Error in processing! ' + textStatus);
            },
        })            
        };           
            
        </script>
    </body>
    <!-- patients23:19-->
</html>