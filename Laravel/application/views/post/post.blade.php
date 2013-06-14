@layout('template')

@section('title')
    Single post
@endsection

@section('main_content')
    <div class="post">
		<h1>
			{{ HTML::link_to_route('view_post', $post->title, $post->id) }}
		</h1>
		<p>
			{{ $post->content }}
		</p>
		<p>
			{{ $author->username }}
		</p>
		<p>
			{{ HTML::link_to_route('home', '&larr; Back to index') }}
		</p>
	</div>
@endsection