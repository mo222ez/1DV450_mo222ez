<!DOCTYPE html>
<html>
  <head>
    <title>
      @yield('title')
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    {{ Asset::styles() }}
    {{ Asset::scripts() }}
  </head>
  <body>
    <div class="container" id="main_container">
      @if (Auth::user())
        {{ HTML::link('logout', 'Logout') }}
      @else
        {{ HTML::link('login', 'Login') }}
      @endif
      @yield('main_content')
    </div>
  </body>
</html>