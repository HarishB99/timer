<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Game Timer Test</title>
<link href="/GameTimer/style/mdl/material.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
<script src="/GameTimer/style/mdl/material.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/GameTimer/scripts/jquery.countdown-2.1.0/jquery.countdown.min.js"></script>
<script src="/GameTimer/scripts/Ajax.js"></script>
<style>
	.mdl-layout__content {
        background-color: #3b3b3b;
    } .page-content {
        color: white;
    }
    
    .demo-card-wide {
		margin: auto;
		margin-top: 5%;
		width: 100%;
	}
    
	.demo-card-wide.mdl-card {
		width: 90%;
		padding: 2.5%;
	}
	
	#fixed-tab-2 .demo-card-wide.mdl-card {
		text-align: center;
	}
    
	#fixed-tab-2 .mdl-card__title-text {
		margin: auto;
	}
</style>
</head>
<body>
<!-- Simple header with fixed tabs. -->
<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header
            mdl-layout--fixed-tabs">
  <header class="mdl-layout__header">
    <div class="mdl-layout__header-row">
      <!-- Title -->
      <span class="mdl-layout-title">Sample Timer</span>
    </div>
    <!-- Tabs -->
    <div class="mdl-layout__tab-bar mdl-js-ripple-effect">
      <a href="#fixed-tab-1" class="mdl-layout__tab">Introduction</a>
      <a href="#fixed-tab-2" class="mdl-layout__tab is-active">Timer</a>
      <a href="#fixed-tab-3" class="mdl-layout__tab">Explanation</a>
    </div>
  </header>
  <!-- <div class="mdl-layout__drawer">
    <span class="mdl-layout-title">Sample Timer</span>
  </div>-->
  <main class="mdl-layout__content">
    <section class="mdl-layout__tab-panel" id="fixed-tab-1">
      <div class="page-content">
		<div class="demo-card-wide mdl-card mdl-shadow--2dp">
            <div class="mdl-card__title">
                <h2 class="mdl-card__title-text">New Game</h2>
            </div>
            <div class="mdl-card__supporting-text">
                The sample timer uses a jquery countdown API. More info on this API can be found <a href="http://hilios.github.io/jQuery.countdown/">here</a>.
				<br/>
				To view the timer in action, please move on to the next tab.
            </div>
        </div>
	  </div>
    </section>
    <section class="mdl-layout__tab-panel is-active" id="fixed-tab-2">
      <div class="page-content">
      	<div class="demo-card-wide mdl-card mdl-shadow--2dp">
            <div class="mdl-card__title">
                <h2 class="mdl-card__title-text timer">hi</h2>
            </div>
            <div class="mdl-card__supporting-text">
                <p>
                	Open up the Developers Console and call the startTimer() function.
	                <br/>
	                Try calling it three times. The first time with one integer argument, the second time with two and the third time with three.
	                <br/>
	                Observe what happens to the timer when you call the function using different arguments. 
	                <br/>
	                <br/>
	            </p>
            </div>
        </div>
	  </div>
    </section>
    <section class="mdl-layout__tab-panel" id="fixed-tab-3">
      <div class="page-content">
	  	<div class="demo-card-wide mdl-card mdl-shadow--2dp">
            <div class="mdl-card__title">
                <h2 class="mdl-card__title-text">Behind the scenes...</h2>
            </div>
            <div class="mdl-card__supporting-text">
                <p>
                	startTimer() makes use of a jquery countdown API which makes coding out JavaScript timers extremely easy.
                	<br/>
                	At the end of the timer, startTimer() makes a request to the respective servlet which sends back a response. In this case, "Timer Has Ended".
	            </p>
            </div>
            <div class="mdl-card__title">
            	<h2 class="mdl-card__title-text">Now for the Serious Stuff</h2>
            </div>
            <div class="mdl-card__supporting-text">
                <p>
                	Please let me know if you all are okay with this timer, especially whether you are okay with integrating this timer with the game board. Thank you.
	            </p>
            </div>
        </div>
	  </div>
    </section>
  </main>
</div>
<script>
function startTimer() {
	let SECONDS = 1000;
	let MINUTES = 60 * SECONDS;
	let HOURS = 60 * MINUTES;
	let date = new Date().getTime();
	switch(arguments.length) {
	    case 1:
	        if (Number.isInteger(arguments[0])) {
	            $('.timer').countdown( (date + ((parseInt(arguments[0]) * 60 * 60 * 1000))), function(event) {
	            	$(this).text(
	             		      event.strftime('%H:%M:%S')
	             		    );
	  	            } )
	            .on('finish.countdown', function() {
	                Ajax.post("/GameTimer/TimerController", "timeEnded", "true")
	                .then(res => {
	                	document.querySelector(".timer").innerHTML = res;
	                })
	                .catch(err => {
	                	console.log('Got an error', err);
	                });
	            });
	        }
	        break;
	    case 2:
	        if (Number.isInteger(arguments[0]) && Number.isInteger(arguments[1])) {
	            $('.timer').countdown( (date + ((parseInt(arguments[0]) * HOURS) + (parseInt(arguments[1]) * MINUTES))), function(event) {
	            	$(this).text(
	             		      event.strftime('%H:%M:%S')
	             		    );
	  	            } )
	            .on('finish.countdown', function() {
	                Ajax.post("/GameTimer/TimerController", "timeEnded", "true")
	                .then(res => {
	                	document.querySelector(".timer").innerHTML = res;
	                })
	                .catch(err => {
	                	console.log('Got an error', err);
	                });
	            });
	        }
	        break;
	    case 3:
	    	if (Number.isInteger(arguments[0]) && Number.isInteger(arguments[1]) && Number.isInteger(arguments[2])) {
	            $('.timer').countdown( (date + ((parseInt(arguments[0]) * HOURS) + (parseInt(arguments[1]) * MINUTES) + (parseInt(arguments[2]) * SECONDS))), function(event) {
	            	$(this).text(
           		      event.strftime('%H:%M:%S')
           		    );
	            } )
	            .on('finish.countdown', function() {
	                Ajax.post("/GameTimer/TimerController", "timeEnded", "true")
	                .then(res => {
	                	document.querySelector(".timer").innerHTML = res;
	                })
	                .catch(err => {
	                	console.log('Got an error', err);
	                });
	            });
	        }
	        break;
	    default:
	    	throw new Error("Invalid number of arguments passed in");
        	break;
	}
}

startTimer(0, 0, 10);
</script>
</body>
</html>