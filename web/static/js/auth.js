export var Auth = {

  init(elmApp) {
    console.log('init Auth');
    window.checkLoginState = this.checkLoginState;
    window.Auth = this;
    this.elmApp = elmApp;
  },

  checkLoginState() {
    console.log('checkLoginState');
    FB.getLoginStatus(function(response) {
      window.Auth.statusChangeCallback(response)
    })
  },

  getAuth() {
    const storedAuth = window.localStorage.getItem('talent-grid-auth')
    return storedAuth ? JSON.parse(storedAuth) : this.getDefaultAuth()
  },

  getInitialAuth() {
    return { id: '', name: '', timezone: 0, email: '', facebookAccessToken: '' }
  },

  setAuth(auth) {
    const oldAuth = this.getAuth()

    // Only store the authentication if different
    if (oldAuth.authenticated !== auth.authenticated) {
      const authJson = JSON.stringify(auth)
      window.localStorage.setItem(authKey, authJson)
    }
  },

  showFacebookLogin() {
    document.getElementById('elm-main').style.display = 'none'
    document.getElementById('fblogin').style.display = 'block';

    (function (d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0]
      if (d.getElementById(id)) return
      js = d.createElement(s); js.id = id
      js.src = '//connect.facebook.net/en_US/sdk.js'
      fjs.parentNode.insertBefore(js, fjs)
    }(document, 'script', 'facebook-jssdk'))
  },

  hideFacebookLogin() {
    document.getElementById('elm-main').style.display = 'block'
    document.getElementById('fblogin').style.display = 'none';
  },

  handleFacebookResponse(fbResponse) {
    fbResponse.facebookAccessToken = this.facebookAccessToken // Mutation, but fuck it, my main app is in Elm LOL!
    console.log(fbResponse);
    this.elmApp.ports.facebookLogin.send(fbResponse);
  },

  statusChangeCallback(response) {
    console.log(response);
    if (response.status === 'connected') {
      this.facebookAccessToken = response.authResponse.accessToken // Another mutation and also fuck it - see above LOL!
      FB.api('/me?fields=name,email,timezone', this.handleFacebookResponse.bind(this))
    } else if (response.status === 'not_authorized') {
      alert('Facebook login is not authorized')
    } else {
      alert('Unknown Facebook login status')
    }
  }
}
