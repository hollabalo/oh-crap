// OhCrap v. 1.0
// 2015 JM Gerona
// Voyager

public class GameplayScene : SEScene, SEPeriodicTimerHandler
{
	int life = 10;
	double score = 0;
	SELayer gameplay;
	SELayer gameover;
	SESprite background;
	SESprite lifeLabel;
	SESprite scoreLabel;
	SESprite totalscore;
	SEResourceCache rs;
	SEButtonEntity btn_main;
	PersonEntity person;
	PoopEntity poop;

	public void initialize(SEResourceCache rsc) {
		base.initialize(rsc);
		rs = rsc;
		assets();
		gameplay = add_layer(0, 0, get_scene_width(), get_scene_height());
		bg();
		score_texts();
		add_entity(SEPeriodicTimer.for_handler(this, 500000));
		create_person();
		create_poop();
	}

	public void on_message(Object o) {
		if("menu".equals(o)) {
			clear_entities();
			pop_scene();
			switch_scene(new MenuScene());
			return;
		}
	}
	
	public bool on_timer(TimeVal now) {
		if(life > 0) {
			create_poop();
			score_add();
		}
		else {
			game_over();
		}
		return(true);
	}

	public void cleanup() {
		base.cleanup();
		background = SESprite.remove(background);
	}

	public void create_poop() {
		add_entity(poop = new PoopEntity());
		poop.set_container(gameplay);
	}

	public void create_person() {
		add_entity(person = new PersonEntity());
		person.set_container(gameplay);
	}

	public void game_over() {
		rs.prepare_image("gameover", "gameover", get_scene_width(),
			get_scene_height());
		gameover = add_layer(0, 0, get_scene_width(), get_scene_height());
		background = gameover.add_sprite_for_image(SEImage.for_resource("gameover"));
		rs.prepare_image("btn_main", "btn_main", get_scene_width()*0.3, get_scene_height()*0.2);
		btn_main = SEButtonEntity.for_image(SEImage.for_resource("btn_main"))
			.set_data("menu")
			.set_listener(this);
		add_entity(btn_main);
		totalscore = gameover.add_sprite_for_text("Total score: %d".printf().add(score).to_string(), "blue");
		totalscore.move(get_scene_width()/2, 20);
		btn_main.move(get_scene_width()/2 - 300 , get_scene_height()/2);
		btn_main.set_container(gameover);
	}

	public void life_subtract() {
		life--;
		lifeLabel.set_text("Life: %d".printf().add(life).to_string(), "smallwhite");
	}

	public void score_add() {
		score += 0.5;
		scoreLabel.set_text("Time survived: %d".printf().add(score).to_string(), "smallwhite");
	}

	public void bg() {
		rs.prepare_image("background", "bg", get_scene_width(),
			get_scene_height());
		background = gameplay.add_sprite_for_image(SEImage.for_resource("background"));
		background.move(0, 0);
	}

	public void assets() {
		rs.prepare_font("smallwhite", "arial color=white", 40);
		rs.prepare_font("black", "arial color=black", 70);
		rs.prepare_font("blue", "arial color=blue", 70);
		rs.prepare_font("red", "arial color=red", 70);
		rs.prepare_image("poop", "poop", px("0.5mm"), px("0.5mm"));
		rs.prepare_image_sheet("image", null, 7, 4, 27,
			get_scene_width() * 0.1, get_scene_height() * 0.15);
		rs.prepare_image_sheet("image2", null, 7, 4, 27,
			get_scene_width() * 0.1, get_scene_height() * 0.15);
	}

	public void score_texts() {
		lifeLabel = gameplay.add_sprite_for_text("Life: %d".printf().add(life).to_string(), "smallwhite");
		lifeLabel.move(50,50);
		scoreLabel = gameplay.add_sprite_for_text("Time survived: %d".printf().add(score).to_string(), "smallwhite");
		scoreLabel.move(get_scene_width() - 330, 50);
	}

	public int get_person_x() {
		return(person.get_x());
	}

	public int get_person_y() {
		return(person.get_y());
	}

	public int get_person_width() {
		return(person.get_width());
	}

	public int get_person_height() {
		return(person.get_height());
	}
}
