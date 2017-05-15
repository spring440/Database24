--This procedure I created just incase
-- The Backup simple doesn't really work, so I did this just
-- In case the DB needs to be restored
CREATE PROC rebuildTables
  AS
  BEGIN
    create table People
(
	people_id int not null identity
		primary key,
	first_name nvarchar(40) not null,
	last_name nvarchar(40) not null
)

create table Sponsors
(
	sponsor_id int not null identity
		primary key,
	sponsor_name varchar(40) not null,
	sponsor_status varchar(20) not null
)


create table Events
(
	event_id int not null
		primary key,
	event_date datetime not null,
	event_name varchar(60) default 'SQLSaturday' not null,
	event_location_id int not null
)


create unique index Events_event_id_uindex
	on Events (event_id)


create table Event_Locations
(
	event_location_id int not null identity
		primary key,
	event_city varchar(40) not null,
	event_region varchar(60) not null
)


alter table Events
	add constraint FK_Events_Event_Locations
		foreign key (event_location_id) references Event_Locations (event_location_id)


create table Attendee_Location
(
	attendee_location_id int not null identity
		primary key,
	attendee_address varchar(50) not null,
	attendee_city varchar(40) not null,
	[attendee_state/country] varchar(50) not null,
	attendee_zip varchar(20) not null
)


create table sysdiagrams
(
	name sysname not null,
	principal_id int not null,
	diagram_id int not null identity
		primary key,
	version int,
	definition varbinary,
	constraint UK_principal_name
		unique (principal_id, name)
)


create table Organizer
(
	organizer_id int not null identity
		primary key,
	people_id int not null
		constraint FK_Organizer_People
			references People (people_id),
	organizer_task varchar(30) not null,
	event_id int not null
)


create table Volunteer
(
	volunteer_id int not null identity
		primary key,
	people_id int not null
		constraint FK_Volunteer_People
			references People (people_id),
	volunteer_tasks varchar(40) not null,
	event_id int not null
)


create table Presenter
(
	presenter_id int not null identity
		primary key,
	people_id int not null
		constraint FK_Presenter_People
			references People (people_id),
	speaking_experience varchar(20) default 'None' not null
)


create table Attendee
(
	attendee_id int not null identity
		primary key,
	people_id int not null
		constraint FK_Attendee_People
			references People (people_id),
	attendee_location_id int not null
		constraint FK_Attendee_Attendee_Location
			references Attendee_Location (attendee_location_id),
	email varchar(30) not null
)


create table Grade
(
	grade_id int not null identity
		primary key,
	presentation_id int not null,
	average_grade int not null
)


create table Presentation
(
	presentation_id int not null identity
		primary key,
	title varchar(100) not null,
	people_id int not null
		constraint FK_Presentation_People
			references People (people_id),
	difficulty varchar(20) default 'Not Given',
	event_location_id int default 73
		constraint FK_Presentation_Event_Locations
			references Event_Locations (event_location_id)
)


alter table Grade
	add constraint FK_Grade_Presentation
		foreign key (presentation_id) references Presentation (presentation_id)


create table Track
(
	track_id int not null identity
		primary key,
	topic varchar(40) not null
)


create table Classroom
(
	class_id int not null identity
		primary key,
	event_id int not null,
	room_number int not null,
	capacity int default 30 not null
)


create table Tables
(
	table_id int not null identity
		primary key,
	table_number int,
	event_id int not null
		constraint FK_Tables_Events
			references Events (event_id),
	sponsor_id int not null
		constraint FK_Tables_Sponsors
			references Sponsors (sponsor_id)
)


create table Schedule
(
	schedule_id int not null identity
		primary key,
	presentation_id int not null
		constraint FK_Schedule_Presentation
			references Presentation (presentation_id),
	class_id int
		constraint FK_Schedule_Classroom
			references Classroom (class_id),
	start_time datetime not null,
	duration int default 60,
	track_id int not null
		constraint FK_Schedule_Track
			references Track (track_id)
)

  END
GO
