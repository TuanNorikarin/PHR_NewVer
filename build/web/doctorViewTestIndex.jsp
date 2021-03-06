<!DOCTYPE html>
<html lang="en">


    <!-- blog23:34-->
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

            .sidebar-menu li#aTestIndex a {
                color: #009efb;
                /*background-color: #2a9c31;*/
                background-color: #e3e7e8;
            }
            div.dropdown.dropdown-action{
                float: right;
            }
            #indexTable {
                width: 100% !important;
            }
            div.col-sm-3.col-3{
                position: relative; 
                
                top: 80px;
                z-index: 10;
            }

        </style>
    </head>

    <%@include file="components/doctorHeader.html" %>
    <%@include file="components/doctorSidebar.html" %>

    <div class="page-wrapper">
        <div class="content">
            <div class="row">
                <div class="col-sm-4 col-3">
                    <h4 class="page-title">All Test Indexes</h4>
                </div>
                <div class="col-sm-3 col-3">
                     <label><h4>Type</h4></label>
                     <select>
                         <option value="adult">Adult</option>
                         <option value="children">Children</option>
                         
                     </select>
                    </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div class="">

                        <table id="indexTable" class="table table-bordered datatable mb-0">

                            <thead>
                                <tr>
                                    <th style="width: 20%">Name</th>
                                    <th>Description</th>
                                    <th style="width: 20%">Male Value</th>
                                    <th style="width: 20%">Female Value</th>
                                    <th style="width: 20%">Price</th>
                                    <!--<th style="width: 5%" class="text-right">Action</th>-->
                                </tr>
                            </thead>

                            <tbody>

                                <tr> 

                                    <td id="name"></td>
                                    <td id="description"></td>
                                    <td id="maleVal"></td>
                                    <td id="femaleVal"></td>
                                    <td id="priceVal"></td>
                                </tr>



                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="overlay"></div>
        <%@include file="components/doctorFooter.html" %>
        <script src="assets/js/jquery-3.2.1.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.slimscroll.js"></script>
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap4.min.js"></script>
        <script src="assets/js/moment.min.js"></script>
        <script src="assets/js/app.js"></script>
        <script type="text/javascript">
//==============================Loading Page=========================================
            $(document).ajaxStart(function () {
                $("div").addClass("loading");
            });
            $(document).ajaxStop(function () {
                $("div").removeClass("loading");
            });

                        window.onload = function () {
                        var token = sessionStorage.getItem("key");
                        var testName = localStorage.getItem("testName");
                        $.ajax({
                            type: "GET",
                            dataType: "json",
                            contentType: "application/json; charset=UTF-8",
                            headers: {
                                 Authorization: 'Bearer ' + token
                            },
                            url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/tests/test-indexs",
                            success: function (data) {
                                var mainData = [];
                                console.log(data);
                                data.forEach(element => {
                                    var dataShow = new Object();
                                    dataShow.name = element.name;
                                    dataShow.description = element.description;
                                    dataShow.price = element.price;
                                    dataShow.maleIndex = '-';
                                    dataShow.femaleindex = '-';
                                    dataShow.childIndex = '-'
                                    
                                    element.samplelst.forEach(e => {
                                        if (e.type === 'Male' || e.type === 'male') {
                                            dataShow.maleIndex = e.indexValueMin + '-' + e.indexValueMax;
                                        } else if (e.type === 'Female' || e.type === 'female') {
                                            dataShow.femaleindex = e.indexValueMin + '-' + e.indexValueMax;
                                        } 
                                    });
                                    mainData.push(dataShow);
                                });
                                console.log(mainData);
                                table = $('#indexTable').DataTable({
                                    data: mainData,
                                    columns: [
                                        { data: 'name' },
                                        {
                                            data: 'description',
                                        },
                                        {
                                            data: 'maleIndex',
                                            render: function (data, type, row, meta) {
                                                if ( row.maleIndex === '-9999--9999') {
                                                    return "??m t??nh";
                                                }else{
                                                    return row.maleIndex;
                                                }
                                            }
                                        },
                                        {
                                            data: 'femaleindex',
                                            render: function (data, type, row, meta) {
                                                if ( row.femaleindex === '-9999--9999') {
                                                    return "??m t??nh";
                                                }else{
                                                    return row.femaleindex;
                                                }
                                            }
                                        },
                                        {
                                            data: 'price',
                                            render: function (data, type, row, meta) {                                                
                                                return row.price;
                                            }
                                        },
                                    ],
                                    "bDestroy": true,
                                    "bFilter": true,
                                   

                                });

                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.log(' Error in processing! ' + textStatus);
                            }

                        })
                        
                $('select').on('change', function() {
                var _type = $(this).val();
                var token = sessionStorage.getItem("key");
                $.ajax({
                    type: "GET",
                    dataType: "json",
                    contentType: "application/json; charset=UTF-8",
                    headers: {
                        Authorization: 'Bearer ' + token},
                    url: "http://14.161.47.36:8080/PHR_System-0.0.1-SNAPSHOT/tests/test-indexs",
                    success: function (data) {
                        var mainData = [];
                        console.log(data);
                        data.forEach(element => {                           

                            var dataShow = new Object();
                            dataShow.id = element.id;
//                          dataShow.testId = element.samplelst[0];
                            dataShow.name = element.name;
                            dataShow.description = element.description;

                            dataShow.maleIndex = '-';
                            dataShow.femaleindex = '-';
                            dataShow.price = element.price;
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
                        
                        localStorage.setItem("allTestIndex", JSON.stringify(mainData));
                        var a = JSON.stringify(data);
                        var b = JSON.parse(a);
                        
                        $('#indexTable tbody').on('click', 'td', function ()
                        {
                            var tr = $(this).closest("tr");
                            var rowindex = tr.index();
                            table = document.getElementById("indexTable");
                            tr = table.getElementsByTagName("tr");
                            td = tr[rowindex + 1].getElementsByTagName("td")[0];
                            txtValue = td.textContent;
                            
                            $.each(mainData, function (index, value,) {
                                if (value[0] === txtValue) {
                                    localStorage.setItem("dataTest", value);
                                }
                            });
                            $.each(mainData, function (index, value) {
                                console.log(value);
                                if (value[0] === txtValue) {
                                    localStorage.setItem("dataTestId", value);
                                }
                            });

                        }
                        );
                        $('td').click(function () {
                            var row_index = $(this).parent().index();

                        });
                        $('#indexTable').DataTable({
                            data: mainData,
                            columns: [
                                { data: 'name' },
                                {
                                    data: 'description'
                                },

                                {
                                    data: 'maleIndex',
                                    render: function (data, type, row, meta) {
                                        if ( row.maleIndex === '-9999--9999') {
                                            return "??m t??nh";
                                        }else{
                                            return row.maleIndex;
                                        }
                                    }
                                },
                                {
                                    data: 'femaleindex',
                                    render: function (data, type, row, meta) {
                                        if ( row.femaleindex === '-9999--9999') {
                                            return "??m t??nh";
                                        }else{
                                            return row.femaleindex;
                                        }
                                    }
                                },
                                {
                                    data: 'price',
                                    render: function (data, type, row, meta) {                                                
                                        return row.price;
                                    }
                                },
                                
                            ],
                            "bDestroy": true,
                            "bFilter": true,

                        });

                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(' Error in processing! ' + textStatus);
                    }
                })
            });
            };


        </script>


    </body>


    <!-- patients23:19-->
</html>