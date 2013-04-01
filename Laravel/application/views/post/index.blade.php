@layout('template')

@section('title')
	Blogg
@endsection

@section('main_content')
	@forelse ($posts as $post)
		<div class="post">
			<h2>
				{{ HTML::link('view/' . $post->id, $post->title) }}
			</h2>
			<p>
				{{ substr($post->content, 0, 120).' [...]' }}
			</p>
			<p>
				{{ HTML::link('view/' . $post->id, 'Read more &rarr;') }}
			</p>
		</div>
	@empty
		<h2>
			No posts
		</h2>
	@endforelse
@endsection