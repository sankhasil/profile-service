/**
 * 
 */
package com.boisoft.controller;

import com.boisoft.model.Profile;
import com.boisoft.service.ProfileService;

import io.micronaut.http.HttpHeaders;
import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Header;
import io.micronaut.http.annotation.Produces;
import jakarta.inject.Inject;

/**
 * @author sankynymous
 *
 */
@Controller("profile")
public class ProfileController {

	@Inject
	ProfileService profileService;

	@Get
	@Produces(MediaType.APPLICATION_JSON)
	public Profile getProfile(@Header(HttpHeaders.AUTHORIZATION) String token) {
		return profileService.getAndProcessProfile(token);
	}

}
