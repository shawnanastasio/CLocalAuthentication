//
//  CLocalAuthentication.h
//  CLocalAuthentication
//
//  Created by Shawn Anastasio on 6/9/17.
//  Copyright © 2017 Shawn Anastasio. Licensed under the terms of the GNU GPL v3.

#ifndef CLocalAuthentication_h
#define CLocalAuthentication_h

/**
 * Check if the current machine supports TouchID
 * @return bool can this machine use TouchID?
 */
bool supports_touchid(void);

/**
 * Prompt the user to authenticate with touchid using the given reason
 * @param reason C-style string containing reason for TouchID request
 * @return did the user authenticate successfully?
 */
bool authenticate_user_touchid(char *reason);

#endif /* CLocalAuthentication_h */
