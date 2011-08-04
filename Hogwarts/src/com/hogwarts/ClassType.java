package com.hogwarts;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

import com.google.appengine.api.users.User;


@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class ClassType {
	@PrimaryKey
    @Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
    private Long id;
	
	@Persistent
	private Date date;
	
	@Persistent
	private List<User> students;
	
	@Persistent
	private String name;
	

	
	public ClassType(String name,Date date,User creator){
		this.name = name;
		this.date = date;
		this.students = new ArrayList<User>();
		this.students.add(creator);
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public Long getId() {
		return id;
	}
	
	public List<User> getstudents() {
		return students;
	}
	
	public void setstudents(List<User> students) {
		this.students = students;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date getDate() {
		return date;
	}

}
