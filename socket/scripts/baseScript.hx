function init() {
	if (this.data.left == null) {
		this.data.left = new openfl.display.Sprite();
	}
	
	if (this.data.right == null) {
		this.data.right = new openfl.display.Sprite();
	}
	
	if (this.data.ball == null) {
		this.data.ball = new openfl.display.Sprite();
		initBall();
	}
	
	var left = this.data.left;
	var right = this.data.right;
	
	this.addChild(left);
	this.addChild(right);
	
	drawRaquette(left);
	drawRaquette(right);
	
	drawBall();
	
	right.x = 800 - right.width;

	this.stage.removeEventListener("keyDown", this.data.onKeyDown);
	this.data.onKeyDown = onKeyDown;
	this.stage.addEventListener("keyDown", this.data.onKeyDown);
	
}

function onKeyDown(e) 
{
	trace(e);
	var left = this.data.left;
	var right = this.data.right;
	
	var code = e.charCode;
	
	if (code == 122) {
		left.y -= 20;
	}else if (code == 115) {
		left.y += 20;
	}
	
	if (code == 111) {
		right.y -= 20;
	}else if (code == 108) {
		right.y += 20;
	}
	
	if (code == 114) {
		initBall();
	}
}

function initBall() {
	this.data.ball.x = 400 - 15;
	this.data.ball.y = 240 - 15; 
	this.data.vitX = 10;
	this.data.vitY = 10;
}

function update(time : Int) {
	
	var ball = this.data.ball;
	ball.x += this.data.vitX;
	ball.y += this.data.vitY;
	
	if (ball.y > 480 - 30){
		this.data.vitY *= -1;
		ball.y = 480 - 30;
	}else if (ball.y < 0) {
		this.data.vitY *= -1;
		ball.y = 0;
	}
	
	if (ball.x > 800 - 30){
		this.data.vitX *= -1;
		ball.x = 800 - 30;
	}else if (ball.x < 0) {
		this.data.vitX *= -1;
		ball.x = 0;
	}
	
}

function drawRaquette(raquette : openfl.display.Sprite) {
	raquette.graphics.clear();
	raquette.graphics.beginFill(0xffffff);
	raquette.graphics.drawRect(0, 0, 30, 200);
}

function drawBall() {
	var ball = this.data.ball;
	
	ball.graphics.clear();
	ball.graphics.beginFill(0xffffff);
	ball.graphics.drawRect(0, 0, 30, 30);
	
	this.addChild(ball);
	
}



