// js/views/app.js
var app = app || {};

// The Application

// 

app.OMockView = Backbone.View.extend({
	// 새로운 요소를 생성하는 대신에 HTML에 이미 존재하는 App구조에 바인딩한다.
	el: '#omockapp',
	
	// 새로운 항목들을 생성하고 완료된 항목들을 삭제하는 위임된 이벤트들
	events: {
		'click #cvs': 'drawLine',
	},
	
	// 초기화 시점에 우리는 항목이 추가되거나 변경될때 관련된 이벤트르를 Todos 컬렉션에 바인딩한다. localStorage에 저장되어 있을 이미 존재하는 할일들을 로딩하는 것으로 시작한다.
	initialize: function() {
		this.canvas = this.$('#cvs')[0];
		console.log(this.canvas);
		this.context = this.canvas.getContext("2d");
		
	},
	
	
	drawLine: function () {
		this.context.strokeStyle = "red";
		this.context.lineWidth = 10;
		this.context.beginPath();
		this.context.moveTo(0, 100);
		this.context.lineTo(100, 0);
		this.context.stroke();
		this.context.closePath();
		
	}
});