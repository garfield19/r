class Notifications
	constructor: ->
		@notifications = $("[data-behavior='notifications']")
		@setup() if @notifications.length > 0

	setup: -> 
		$("[data-behavior='notifications-link']").on "click", @handleClick
		$.ajax(
			url: "/notifications.json"
			dataType: "JSON"
			method: "GET"
			success: @handleSuccess
		)

	handleClick: (e) =>
		$.ajax(
			url: "/notifications/mark_as_read"
			method: "POST"
			dataType: "JSON"
			success: ->
				$("[data-behavior='unread-count']").text(0)
		)

	handleSuccess: (data) =>
		console.log(data)
		items = $.map data, (notification) ->
			"<li><a class='dropdown-item' href='#'>#{notification.actor} #{notification.action} #{notification.notifiable.type}</a></li>"
		$("[data-behavior='unread-count']").text(items.length)
		$("[data-behavior='notification-items']").html(items)
		console.log(items)

jQuery ->
	new Notifications