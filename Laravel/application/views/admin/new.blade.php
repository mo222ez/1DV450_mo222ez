@layout('template')

@section('title')
    New post
@endsection

@section('main_content')
    <h1>New post</h1>
    <h2>Welcome, {{ Auth::user()->username }}!</h2>

    {{ Form::open('admin') }}
    	<!-- author -->
    	{{ Form::hidden('author_id', $user->id) }}
        <!-- title field -->
        <p>{{ Form::label('title', 'Title') }}</p>
        {{ $errors->first('title', '<p class="error">:message</p>') }}
        <p>{{ Form::text('title', Input::old('title')) }}</p>

        <!-- body field -->
        <p>{{ Form::label('content', 'Content') }}</p>
        {{ $errors->first('content', '<p class="error">:message</p>') }}
        <p>{{ Form::textarea('content', Input::old('content')) }}</p>

        <!-- submit button -->
        <p>{{ Form::submit('Create', array('class' => 'btn btn-primary')) }}</p>
    {{ Form::close() }}
@endsection