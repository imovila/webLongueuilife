<%@  Language="javascript" %>

<%
    var con = Session("myCon"),
        recPersInfo = new ActiveXObject("ADODB.RecordSet"), friend = Request.Form("friend");

    //**Manage Friend Request For This User**//
    if (Request.QueryString('reqfriend') != null){
      if (Request.QueryString('action') == 'a'){
        con.Execute("insert into friends (userid, friend) values (" + Session("userId") + ", " + Request.QueryString('reqfriend') + ")");
      }
      if (Request.QueryString('action') == 'd'){
        con.Execute("delete from friends where friend = " + Session("userId") + " and userid = " + Request.QueryString('reqfriend'));
      }
    }
    //*********************************//

    //***Add Friend to Friends List***//
    if (friend != null){
        var recFriend = new ActiveXObject("ADODB.RecordSet");
        recFriend.Open("select id from friends where (userid = " + Session("userId") + " and friend = " + Request.Form("friend") + ") or (" +
                       " friend = " + Session("userId") + " and userid = " + Request.Form("friend") + ")", con);
        if (recFriend.BOF){
            con.Execute("insert into friends (userid, friend) values (" + Session("userId") + ", " + Request.Form("friend") + ")");
           // Response.Write("<script>alert('You added a new friend to your chat list !')</script>");
        }
    }
    //*********************************//
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Longueuilife - Direct Messaging</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="../assets/css/main.css" />
    <link rel="stylesheet" href="../assets/css/picslide.css" />
    <link rel="stylesheet" href="../assets/css/account.css" />
    <script src="../assets/js/dropdown.js"></script>
    <script>
        function moveScroll() {
            window.scrollTo(0, 350);
        }
    </script>
</head>

<body onload="moveScroll()">

    <!-- Header -->
    <header id="header">
        <nav class="left logo" style="font-size: 18px">
            <h5><br />Hi, <%=Session("thisUserName") %>, you are <span style="color:red; text-decoration: underline;">
                          <%recPersInfo.Open("select count(*) as [cnt] from friends where userid = " + Session("userId"), con);
                            if (!recPersInfo.EOF) Response.Write(recPersInfo.Fields["cnt"].Value); 
                            else Response.Write(0); recPersInfo.Close(); %></span> friends :) !<br />  Stay in touch !</h5>
        </nav>
        <a href="../index.html" class="logo"><img src="../images/rencontre.jpg" style="max-width: 70px; max-height: 70px; margin-top:5px" alt="">
        Longueuilife</a>
        <nav class="right" style="right: 2em; top: 0; height: 193px">
            <div class="auto-style1">
                <button onclick="myFunction()" class="dropbtn">Menu</button>
                <div id="myDropdown" class="dropdown-content">
                    <a href="../index.html">Home</a>
                    <a href="./friendsRoom.aspx">Chat Room</a>
                    <a href="../index.html">Log Out</a>
                </div>
            </div>
        </nav>
    </header>

    <!-- Search -->
    <section id="banner">
        <div class="content">
            <h1><span id="result_box" class="short_text" tabindex="-1">Find Your Partner</span></h1>
        </div>
    </section>

    <div class="container">
        <div class="containerSearch">
            <form class="form" method="post" action="#">
                <div>
                    <p class="p">
                        <label>
                            Marital status<br>
                            <select name="selMaritalStatus">
                                <option value="" disabled selected>Select...</option>
                                <option value="1">Married</option>
                                <option value="2">Single</option>
                                <option value="3">Divorced</option>
                                <option value="4">Widow</option>
                            </select>
                        </label>
                    </p>
                    <p class="p">
                        <label>
                            Gender<br>
                            <input type="radio" name="radGender" value="2" id="radWoman"><label for="radWoman">Woman</label><br>
                            <input type="radio" name="radGender" value="1" id="radMan"><label for="radMan">Man</label><br>
                        </label>
                    </p>
                    <p class="p">
                        <label>
                            Age<br>
                            between&nbsp;&nbsp;<input type="number" name="txtAgeLeft" min="20" max="100" step="1" value="20">&nbsp;&nbsp;and&nbsp;&nbsp;
		                    <input type="number" min="20" max="100" name="txtAgeRight" step="1">
                        </label>
                    </p>
                    <p class="p">
                        <input type="checkbox" name="cboRandom" value="5" id="cboRandom"><label for="cboRandom">Random 5</label><br>
                    </p>
                    <p class="p">
                        <input type="submit" value="Search Partener">
                    </p>
                    <input type="hidden" name="subCriteria" value="1">
                </div>
            </form>
        </div>
    </div>

    <%  //*************Get Friend Request**************//
        var recFriends = new ActiveXObject("ADODB.RecordSet");
             recFriends.Open("select f1.userid, pic, firstname & ' ' & lastname as [name], dg.name as [gname] from friends f1, pics p, users u, usersinfo ui, dicgender dg " + 
                             " where friend = " + Session("userId") + " and not exists (select * from friends f2 where f2.userid = " + Session("userId") + 
                             " and f2.friend = f1.userid) and f1.userid = p.userid and f1.userid=u.id and u.usersinfo = ui.id and ui.looking = dg.id", con);
        if (!recFriends.EOF){
    %>
     <div class="container" style="position: absolute; right: 20px; width: 250px; height: 230px; border: 3px solid #FF6347; -webkit-box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75);
          -moz-box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75); box-shadow: 10px 10px 5px 0px rgba(0,0,0,0.75); overflow-y: scroll !important">
         <h3 style="margin-left: 15px;">Friend requests:</h3>
      
          <% while(!recFriends.EOF) { 
               var requestID = recFriends.Fields["userid"].Value; %>
                 <p style="margin-left: 15px;">
                     <img src="../<%=recFriends.Fields['pic'].Value %>" style="max-width: 80px; max-height: 70px; vertical-align: text-top; float: left; margin-right: 5px;" alt="">
                     <b><%=recFriends.Fields["name"].Value %><br />Looking: <%=recFriends.Fields["gname"].Value %></b><br />
                     <a href="./account.aspx?reqfriend=<%=requestID %>&action=a" style="text-decoration: none !important;">Accept</a>&nbsp;&nbsp;
                     <a href="./account.aspx?reqfriend=<%=requestID %>&action=d" style="text-decoration: none !important;">Reject</a>
                 </p>
         <% recFriends.MoveNext(); } %>
    </div>
    <% } recFriends.Close(); %>

    <!-- Display USER INFO Container -->
    <div class="container">
        <%  var recCriteria = new ActiveXObject("ADODB.RecordSet"),
                criteria = "", rand = "";

            //*************Set Criteria**************//
            if (Request.Form("subCriteria") == 1){
                if (Request.Form("selMaritalStatus") != null)
                   criteria = " and maritalstatus = " + Request.Form("selMaritalStatus"); 
                
                if (Request.Form("radGender") != null)
                   criteria += " and gender = " + Request.Form("radGender");
    
                if (Request.Form("txtAgeRight") > 0)
                    criteria += " and year(date()) - year(birthdate) between " + Request.Form("txtAgeLeft") + " and " + Request.Form("txtAgeRight");
                
                if (Request.Form("cboRandom") != null)
                    rand = " order by rnd(i.id) ";
  
            }

            //*********Get Full User Data***********//
            recPersInfo.Open("select " + (rand.length > 0 ? " top 5 " : "") + " u.id, pic, firstname & ' ' & lastname as [name], " + 
                                "dm.name as [maritalstatus], dg.name as [gendername] from dicgender dg, dicmaritalstatus dm, pics p, usersinfo i, users u " + 
                                " where u.usersinfo = i.id and u.id = p.userid and i.maritalstatus = dm.id and i.looking = dg.id " + 
                                " and u.id <> " + Session("userId") + " and u.id not in (select f.friend from friends f where f.userid = " + 
                                Session("userId") + ")" + criteria + rand, con);
            var i = 0;
            while (!recPersInfo.EOF){
        %>
        <div class="galleryItem" style="width: 170px; height: 170px;">
            <a href="#" title="Add to friends list" onClick="document.forms['f<%=i %>'].submit();">
                <img src="../<%=recPersInfo.Fields["pic"].Value %>" style="max-width: 150px; max-height: 140px;" alt=""></a>
            <form action="#" name="f<%=i %>" method="post">
                <input type="hidden" name="friend" value="<%=recPersInfo.Fields["id"].Value %>" />
            </form>
            <h3><%=recPersInfo.Fields["name"].Value %></h3>
            <p>
                <%=recPersInfo.Fields["maritalstatus"].Value + ". Looking " + recPersInfo.Fields["gendername"].Value%><br />
                Lorem ipsum dolor sit amet...
            </p>
        </div>
        <% recPersInfo.MoveNext(); i++; } recPersInfo.Close(); %>
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
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/jquery.scrolly.min.js"></script>
    <script src="assets/js/skel.min.js"></script>
    <script src="assets/js/util.js"></script>
    <script src="assets/js/main.js"></script>

</body>
</html>
