<%@  Language="javascript" %>

<%
    var con = Session("myCon"),
        recMsg = new ActiveXObject("ADODB.RecordSet"),
        txtMsgSend = null;
%>

<%  //**********Insert New Message************// 
    if (Request.QueryString("txtMsg") != null) {
        recMsg.Open("select id from friends where userid = " + Session("userID") + " and friend = " + Request.QueryString("receivermsg"), con);
        con.Execute("insert into messages (friends, message) values(" + recMsg.Fields['id'].Value + ", '" + Request.QueryString("txtMsg") + "');");
        recMsg.Close();
        Response.Redirect("friendsRoom.aspx");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Longueuilife - Direct Messaging</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/frendroommain.css" />
    <link rel="stylesheet" href="../assets/css/frendroomreset.css">
    <link rel="stylesheet" href="../assets/css/frendsroomstyle.css">
    <script type="text/javascript">
        function myFunction() {
            document.getElementById("myDropdown").classList.toggle("show");
        }
        window.onclick = function (event) {
            if (!event.target.matches('.dropbtn')) {

                var dropdowns = document.getElementsByClassName("dropdown-content");
                var i;
                for (i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</head>

<body>

    <!-- Header -->
    <header id="header">
        <nav class="left logo" style="font-size: 18px; color: #BBBBBB">
            <p>Hi, <%=Session("thisUserName") %>, stay in touch !</p>
        </nav>
        <nav class="right">
            <div class="dropdown">
                <button onclick="myFunction()" class="dropbtn">Menu</button>
                <div id="myDropdown" class="dropdown-content">
                    <a href="../index.html">Home</a>
                    <a href="./account.aspx">Find Relationship</a>
                    <a href="../index.html"> Log Out</a>
                </div>
            </div>
        </nav>
        <a href="../index.html" class="logo"><img src="../images/rencontre.jpg" style="max-width: 70px; max-height: 70px; margin-top:5px" alt="">
        Longueuilife</a>
    </header>

    <div class="wrapper">
        <div class="container">
            <div class="left">
                <ul class="people">
                    <% //**********Get Messages & Participants************//
                       var recUser = new ActiveXObject("ADODB.RecordSet"),
                       datachat = [], i = 0;
 
                        recMsg.Open("select f.friend, message, Format(Datein,'hh:nn:ss') as timein from friends f, messages m" +
                                    " where f.userid = " + Session('userid') + " and f.id = m.friends and datein =" +
                                    " (select max(m1.datein) from messages m1 where m1.friends=m.friends) union" +
                                    " select f.friend, '', '' from friends f where userid = " + Session("userId") + 
                                    " and not exists (select id from messages where f.id = friends) order by 1 asc;", con);

                        while(!recMsg.EOF){
                            datachat[i] =  recMsg.Fields["friend"].Value;
                    %>
                    <li class="person" data-chat="<%= datachat[i] %>">
                        <img src="../<% recUser.Open('select pic from pics WHERE userid = ' + datachat[i], con); 
                                        Response.Write(recUser.Fields['pic'].Value); recUser.Close(); %>" />
                        <span class="name"><% recUser.Open("select firstname & ' ' & lastname as [name] from users u, usersinfo ui " + 
                                                           " where u.usersinfo=ui.id and u.id = " + datachat[i], con); 
                                        Response.Write(recUser.Fields["name"].Value); recUser.Close(); %></span>
                        <span class="time"><%= recMsg.Fields["timein"].Value %></span>
                        <span class="preview"><%= recMsg.Fields["message"].Value.substr(0, 15) %></span>
                    </li>
                    <% recMsg.MoveNext(); i++; } recMsg.Close();%>
                </ul>
            </div>
            <div class="right">
                <div class="top">
                    <% if (datachat[0] != null){ %>
                    <span>To: <span class="name">
                    <% //**********Get First Friend Data for TOP Chat************// 
                             recUser.Open("select firstname & ' ' & lastname as [name] from users u, usersinfo ui " +
                                          " where u.usersinfo=ui.id and u.id = " + datachat[0], con); 
                             Response.Write(recUser.Fields["name"].Value); recUser.Close(); %> </span></span>
                    <% } %>
                </div>

                <% for(i = 0; i < datachat.length; i++){ %>

                <div class="chat" data-chat="<%=datachat[i] %>">
                    <div class="conversation-start">
                        <span>--</span>
                    </div>
                    <%  //***********Get Message from User & Friend************// 
                        if (recMsg.State == 1) recMsg.Close(); 
                        recMsg.Open("select distinct f.friend, message, datein from messages m, friends f where ((f.friend = " + datachat[i] +
                                    " and f.userid = " + Session("userID") + ") or (f.friend = " + Session("userid") + " and f.userid = " + datachat[i] + "))" + 
                                    " and f.id = m.friends order by datein asc", con);
                    while(!recMsg.EOF) {
                        if (recMsg.Fields["friend"].Value == Session("userID")){
                    %>
                    <div class="bubble you">
                        <%=recMsg.Fields["message"].Value %>
                    </div>
                    <% } else { %>
                    <div class="bubble me">
                        <%=recMsg.Fields["message"].Value %>
                    </div>
                    <% } recMsg.MoveNext(); } %>
                </div>

                <% } if (recMsg.State==1) recMsg.Close(); %>

                <form name="myform" action="#" method="get">
                    <div class="write">
                        <input type="text" name="txtMsg" />
                        <input type="hidden" id="receivermsg" name="receivermsg" value=""/>
                        <a href="#" onclick="myForm()" class="write-link send"></a>
                    </div>
                </form>
                <script type="text/javascript">
                    function myForm() {
                        document.myform.submit();
                    }
                </script>
            </div>

        </div>
    </div>


    <!-- Footer -->
    <footer id="footer">
        <div class="inner">
            <h2>Get In Touch</h2>
            <ul class="actions">
                <li><span class="icon fa-phone"></span><a href="#">(777) 777-7777</a></li>
                <li><span class="icon fa-envelope"></span><a href="#">longueuilife@longueuilife.abc</a></li>
                <li><span class="icon fa-map-marker"></span>123 rue LoremLongueuil, Longueuil, Canada XYZ-XYZ</li>
            </ul>
        </div>
        <div class="copyright">
            &copy; Longueuilife. Design by Ion Movila
        </div>
    </footer>

    <!-- Scripts -->

    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="../assets/js/frendsroomindex.js"></script>

    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/jquery.scrolly.min.js"></script>
    <script src="assets/js/skel.min.js"></script>
    <script src="assets/js/util.js"></script>

</body>
</html>