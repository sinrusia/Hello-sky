var Photo = Backbone.Model.extend({
	default: {
		src: "placeholder.jpg",
		caption: "A default image",
		viewed: false
	},
	initialize: function() {
		
	}
});