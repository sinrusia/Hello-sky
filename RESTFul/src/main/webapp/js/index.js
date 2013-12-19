(function($){

	var Person = Backbone.Model.extend({
		defaults : {
			name : "undefiled"
		},
		idAttribute: "id"
	});
	
	var Persons = Backbone.Collection.extend({
		model: Person,
		url: 'restful/person'
	});
	
	var Index = Backbone.View.extend({
		el:$('#contents'),
		
		initialize: function() {
			this.collection = new Persons();
			this.collection.fetch();
			
			this.collection.on('add', this.addHandle, this);
			this.collection.on('remove', this.removeHandle, this);
			this.collection.on('reset', this.resetHandle, this);
		},
		
		events: {
			'click #addBtn': "postProc",
		},
		
		addHandle: function(person) {
			console.log(person);
			var listItem = new ListItem({model:person});
			$(this.el).append(listItem.render().el);
		},
		
		removeHandle: function(removedBook) {
			var removedBookData = removedBook.attributes;
			_.each(removedBookData, function(val, key){
				if(removedBookData[key] === removedBook.defaults[key]){
					delete removedBookData[key];
				}
			});
			
			console.log('remove');
			console.log(removedBook.get('name'));
		},
		
		resetHandle: function() {
			console.log('resetHandle');
		},
		
		postProc: function(e) {
			e.preventDefault();
			this.collection.create({name:'Go Jae Hag'});	
			console.log('postProc');
		},
		
		getProc: function(e) {
			e.preventDefault();
			console.log('getProc');
		},
		
		deleteProc: function(e) {
			e.preventDefault();
			console.log('delete');
			var m = this.collection.at(0);
			console.log(m);
			m.destroy();
		},
		
		putProc: function(e) {
			e.preventDefault();
			var m = this.collection.at(0);
			m.set('name', 'update');
			m.save();
		}
	
	});
	
	var ListItem = Backbone.View.extend({
		tagName: 'div',
		template: _.template($('#itemTemplate').html()),
		
		events: {
			'click .destroy': 'destroyItem',
			'keyup .txiName': 'updateItem'
		},
		
		render: function() {
			
			this.$el.html(this.template(this.model.toJSON()));
			return this;
		},
		updateItem: function() {
			var val = $('.txiName').val();
			this.model.set('name', val);
			this.model.save();
		},
		
		destroyItem: function() {
			console.log('destroy');
			this.model.destroy();
			this.remove();
		}
	});
	
	var index = new Index();
	
})(jQuery);

