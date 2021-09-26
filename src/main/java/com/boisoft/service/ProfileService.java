/**
 * 
 */
package com.boisoft.service;

import com.boisoft.model.Profile;

import jakarta.inject.Singleton;

/**
 * @author sankynymous
 *
 */
@Singleton
public class ProfileService {

	public Profile getAndProcessProfile(String token) {
		return new Profile("Sankha", "Sanky");
	}
}