<?php

/**
* 
*/
class Post_Controller extends Base_Controller {
	
	public function action_index()
	{
		//$posts = Post::with('author')->all();
		$posts = Post::with('author')->order_by('created_at', 'desc')->get();
		$context = array('posts' => $posts);
		return view::make('post.index', $context);
	}

	public function action_new()
	{
		return view::make('post.new');
	}

	public function action_view($post_id)
	{
		$post = Post::find($post_id);
		$author = $post->author;
		$context = array('post' => $post, 'author' => $author );
		return view::make('post.post', $context);
	}
}

?>