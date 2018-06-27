

    function checkIsNotEmpty(value) {

        if (typeof (value) !== "undefined" && value) {
            return true;
        }
        else {
            return false;
        }
    }

    function createButton(j, bleId, sn, bleName, devicePage) {
        var getDevicePageName = devicePage + "DeviceList";
        //var getDiv = document.getElementById("MAXSceneDeviceList");
        var getDiv = document.getElementById(getDevicePageName);
        var btn = document.createElement("BUTTON");
        var btnRenameEditor = document.createElement("BUTTON");
        var btnSearch = document.createElement("BUTTON");
        //var currentBleName = "MAXScene";
        var subDivId = devicePage + "Div" + j;
        console.log("crbtn subDiv.id =" + subDivId);
        var getSubDiv = document.getElementById(subDivId);

        btn.id = "btn" + devicePage + "_" + j;

        console.log("subDivId =" + subDivId);
        console.log("btn.id =" + btn.id);

        btn.innerHTML = "<span style='font-size:20px;font-weight: bold;'>" + bleName + "&nbsp&nbsp" + j + "</span><br /> ID: " + bleId + sn + "<br />";
        btn.style.height = "38px";
        btn.style.width = "60%";
        btn.className = "boxSt";
        btn.setAttribute('data-bleID', bleId);
        btn.setAttribute('data-bleSN', sn);
        btn.setAttribute('data-bleIDSN', bleId + sn);
        //$(btn).attr('data-bleID', bleId);
        //$(btn).attr('data-bleSN', sn);
        //$(btn).attr('data-bleIDSN', bleId + sn);

        btnRenameEditor.id = "btn" + devicePage + "Edit_" + j;
        btnRenameEditor.className = "btnRenameEdit";

        btnSearch.id = "btn" + devicePage + "Search_" + j;
        btnSearch.className = "btnSearch";
        var btnid = btn.id;
        // 3. Add event handler
        btn.addEventListener("click", function (event) {
            event.preventDefault(); //this will prevent the click event to return anything. otherwise it will return false and prevent page redirect                  
            alert("btnaddevent=" + btn.id);
            var idsn = $(this).data('bleidsn'); // $(this) refers to the button
            alert("idsn=" + idsn)
            var sn = $(this).data('blesn'); // $(this) refers to the button
            console.log("sn=" + sn);

            var redirectPage = devicePage + "KeysPanel.aspx";
            window.location.href = redirectPage;
        });

        // 4. Add event handler
        btnRenameEditor.addEventListener("click", function (event) {
            event.preventDefault();
            alert(btnRenameEditor.id);
            // window.location.replace("MaxSceneDetails.aspx");
        });

        // 4. Add event handler
        btnSearch.addEventListener("click", function (event) {
            event.preventDefault();
            alert(btnSearch.id);
        });

        getSubDiv.appendChild(btn);
        getSubDiv.appendChild(btnRenameEditor);
        getSubDiv.appendChild(btnSearch);
    }

    function createSubDiv(x, SubDivName) {
        //var getDiv = document.getElementById("MAXSceneDeviceList");
        var getSubDivName = SubDivName + "DeviceList";
        console.log("getSubDivName 90 =" + getSubDivName);
        var getDiv = document.getElementById(getSubDivName);
        var subDiv = document.createElement("DIV");
        var btnHR = document.createElement("HR");

        x = x + 1;
        subDiv.id = SubDivName + "Div" + x;
        subDiv.style.height = "60px";
        subDiv.style.width = "100%";
        console.log("subDiv.id =" + subDiv.id);
        btnHR.className = "hrSt";

        getDiv.appendChild(subDiv);
        getDiv.appendChild(btnHR);
    }


