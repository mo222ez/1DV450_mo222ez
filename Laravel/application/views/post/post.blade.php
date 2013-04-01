@layout('template')

@section('title')
    Single post
@endsection

@section('main_content')
    <div class="post">
			<h1>
				{{ HTML::link('view/' . $post->id, $post->title) }}
			</h1>
			<p>
				{{ $post->content }}
			</p>
			<p>
				{{ $author->username }}
			</p>
			<p>
				{{ HTML::link('/', '&larr; Back to index') }}
			</p>
		</div>
@endsection