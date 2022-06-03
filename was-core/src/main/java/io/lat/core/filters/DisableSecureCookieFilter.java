/*
* Copyright 2022 LA:T Development Team.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

package io.lat.core.filters;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.filters.FilterBase;
import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;



/**
 * servlet filter to disable secure attribute of session cookie when set-cookie.
 *
 * @author sangsik
 *
 */
public class DisableSecureCookieFilter extends FilterBase {

	private final Log log = LogFactory.getLog(DisableSecureCookieFilter.class);

	private String sessionCookieName = "JSESSIONID";

	private boolean logging = false;

	public void setSessionCookieName(String sessionCookieName) {
		this.sessionCookieName = sessionCookieName;
	}

	public void setLogging(boolean logging) {
		this.logging = logging;
	}

	@Override
	protected Log getLogger() {
		return log;
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		super.init(filterConfig);
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		if (request instanceof HttpServletRequest
				&& response instanceof HttpServletResponse) {
			request = new ForceUnsecureSessionCookieRequestWrapper(
					(HttpServletRequest) request, (HttpServletResponse) response);
		}

		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}

	class ForceUnsecureSessionCookieRequestWrapper extends HttpServletRequestWrapper {
		HttpServletResponse response;

		public ForceUnsecureSessionCookieRequestWrapper(HttpServletRequest request,
				HttpServletResponse response) {
			super(request);
			this.response = response;
		}

		@Override
		public HttpSession getSession(boolean create) {
			if (create) {
				HttpSession session = super.getSession(create);
				updateCookie(response.getHeaders("Set-Cookie"));
				return session;
			}
			return super.getSession(create);
		}

		@Override
		public HttpSession getSession() {
			HttpSession session = super.getSession();
			if (session != null) {
				updateCookie(response.getHeaders("Set-Cookie"));
			}

			return session;
		}

		protected void updateCookie(Collection<String> cookiesAfterCreateSession) {
			if (cookiesAfterCreateSession != null && !response.isCommitted()) {
				// search if a cookie JSESSIONID Secure exists
				String cookieJSessionId = null;
				for (String cookie : cookiesAfterCreateSession) {
					if (cookie.startsWith(sessionCookieName)
							&& cookie.contains("; Secure")) {
						cookieJSessionId = cookie;
					}
				}

				if (cookieJSessionId != null) {
					// remove all Set-Cookie and add the unsecure version of the
					// JSessionId Cookie
					response.setHeader("Set-Cookie",
							cookieJSessionId.replace("; Secure", ""));
					if (logging) {
						log.info("removed secure flag of session cookie: "
								+ cookieJSessionId);
					}

					// re-add all other Cookies
					for (String cookie : cookiesAfterCreateSession) {
						if (!cookie.startsWith(sessionCookieName)) {
							response.addHeader("Set-Cookie", cookie);
						}
					}
				}
			}
		}
	}
}
