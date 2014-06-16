var PhotoGally = Backbone.Collection.extend({
	model: Photo,
	viewed: function() {
		return this.filter(function(photo){
			return photo.get('viewed');
		});
	},
	unviewed: function() {
		return this.without.apply(this, this.viewed());
	}
});