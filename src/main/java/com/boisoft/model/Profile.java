package com.boisoft.model;

/**
 * 
 * @author sankynymous
 *
 */
public class Profile {

	private String name;
	private String nickName;
	//TODO add more model data
	public Profile(String name, String nickName) {
		this.name = name;
		this.nickName = nickName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
	
}
