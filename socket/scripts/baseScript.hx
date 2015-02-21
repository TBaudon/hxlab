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
	
	if (this.data.scoreLS == null) {
		this.data.scoreLeft = 0;
		this.data.scoreLS = new openfl.display.Sprite();
		this.addChild(this.data.scoreLS);
	}
	
	if (this.data.scoreLR == null) {
		this.data.scoreRight = 0;
		this.data.scoreLR = new openfl.display.Sprite();
		this.addChild(this.data.scoreLR);
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
	
	this.stage.removeEventListener("touchMove", this.data.onClick);
	this.data.onClick = onClick;
	this.stage.addEventListener("touchMove", this.data.onClick);
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

function addPoint(left) {
	var score;
	var sprite;
	if (left) {
		this.data.scoreLeft++;
		score = this.data.scoreLeft;
		sprite = this.data.scoreLS;
	}else {
		this.data.scoreRight++;
		score = this.data.scoreRight;
		sprite = this.data.scoreLR;
	}
	
	sprite.graphics.clear();
	sprite.graphics.beginFill(0xff0000);
	var count = 0;
	while (count < score) {
		sprite.graphics.drawRect(count * 25, 0 , 20, 20);
		count++;
	}
	
	if (!left){
		sprite.x = this.stage.stageWidth - sprite.width;
		sprite.y = this.stage.stageHeight - sprite.height;
	}
}

function onClick(e) {
	var left = this.data.left;
	var right = this.data.right;
	if(e.stageX < this.stage.stageWidth / 2)
		left.y = e.stageY - left.height;
	else
		right.y = e.stageY - right.height;
}

function initBall() {
	this.data.ball.x = 400 - 15;
	this.data.ball.y = 240 - 15; 
	
	var angle = Math.random() * 360 ;
	while(angle > 50 && angle < 180 - 50 || angle > 180 + 50 && angle < 360 - 50)
		angle = Math.random() * 360;
		
	this.data.vitX = Math.cos(angle / 180 * 3.14) * 10;
	this.data.vitY = Math.sin(angle / 180 * 3.14) * 10;
}

function update(time : Int) {
	
	var ball = this.data.ball;
	ball.x += this.data.vitX*1.5;
	ball.y += this.data.vitY * 1.5
	;
	
	var left = this.data.left;
	var right = this.data.right;
	
	if (ball.y > 480 - 15){
		this.data.vitY *= -1;
		ball.y = 480 - 15;
	}else if (ball.y < 15) {
		this.data.vitY *= -1;
		ball.y = 15;
	}
	
	if (ball.x > 830) {
		initBall();
		addPoint(true);
	}else if (ball.x < -30) {
		initBall();
		addPoint(false);
	}
	
	if (ball.x > 800 - 35) {
		if (ball.y >= right.y && ball.y <= right.y + right.height){
			this.data.vitX *= -1;
			ball.x = 800 -35;
			bounceVitY(right);
		}
	}else if (ball.x < 35) {
		if (ball.y >= left.y && ball.y <= left.y + left.height){
			this.data.vitX *= -1;
			ball.x = 35;
			bounceVitY(left);
		}
	}
}

function bounceVitY(raq) {
	var ball = this.data.ball;
	
	this.data.vitY = (ball.y - (raq.y + raq.height/2)) / 10;
}

function drawRaquette(raquette : openfl.display.Sprite) {
	raquette.graphics.clear();
	raquette.graphics.beginFill(0x000000FF);
	raquette.graphics.drawRoundRect(0, 0, 20, 150, 50);
}

function drawBall() {
	var ball = this.data.ball;
	
	ball.graphics.clear();
	ball.graphics.beginFill(0x00FF00);
	ball.graphics.drawCircle(0, 0, 50);
	//ball.graphics.drawRect(-15, -15, 30, 30);
	
	this.addChild(ball);
	
}



