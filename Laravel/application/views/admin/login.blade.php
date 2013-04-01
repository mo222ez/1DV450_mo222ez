@layout('template')

@section('title')
    Login
@endsection

@section('main_content')
    {{ Form::open('login', 'POST', array('id' => 'login_form_wrapper')) }}
        {{ Form::token() }}
        <!-- check for login errors flash var -->
        @if (Session::has('login_errors'))
            <span class="error">Username or password incorrect.</span>
        @endif

        <!-- username field -->
        <div class="field">
            <p>{{ Form::text('username', '', array('class' => 'input-block-level', 'placeholder' => 'username')) }}</p>
        </div>

        <!-- password field -->
        <div class="field">
            <p>{{ Form::password('password') }}</p>
        </div>

        <!-- submit button -->
        <div class="action">
            <p>{{ Form::submit('Login', array('class' => 'btn btn-large btn-block btn-primary')) }}</p>
        </div>

    {{ Form::close() }}
@endsection