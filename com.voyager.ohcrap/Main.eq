// OhCrap v. 1.0
// 2015 JM Gerona
// Voyager

public class Main : SEApplication
{
	public Main() {
		SEDefaultEngine.activate();
	}

	public FrameController create_main_scene() {
		return(new MenuScene());
	}
}
