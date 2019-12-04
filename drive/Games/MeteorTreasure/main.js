// Initialize Phaser, and creates a 400x490px game
var game = new Phaser.Game(document.getElementById("gameDiv").offsetWidth, document.getElementById("gameDiv").offsetHeight, Phaser.AUTO, 'gameDiv');
var score = 0;
var initState = {
    preload: function () {
        // Change the background color of the game
        //game.stage.backgroundColor = '#71c5cf';
        //load background image for the game
        game.load.image("background", "assets/splash screen.jpg");
        
    },
    create: function () {
        this.background = this.game.add.sprite(game.world.centerX, game.world.centerY, "background");
        //this.background.width = game.width / 2 - 310;
        //this.background.height = game.height / 2 - 150;
        this.background.anchor.setTo(0.5, 0.5);
        var text = "Click to start the game.";
        var style = { font: "30px Arial", fill: "#fff", align: "center" };
        score = 0;
        var t = game.add.text(game.world.centerX, game.world.height - 20, text, style);
        t.anchor.setTo(0.5, 0.5);

        var text2 = "Use left/right arrow keys to move player and avoid falling meteors.";
        var style2 = { font: "12px Arial", fill: "#fff", align: "center" };
        var t2 = game.add.text(game.world.centerX, 10, text2, style2);
        t2.anchor.setTo(0.5, 0.5);

        game.input.onDown.addOnce(function () { game.state.start('main'); }, this);

        
    }
};

// Creates a new 'main' state that will contain the game
var mainState = {

    // Function called first to load all the assets
    preload: function () {
        // Change the background color of the game
        //game.stage.backgroundColor = '#71c5cf';

        //load background image for the game
        game.load.image("background", "assets/Background.jpg");
        //load play sprite
        game.load.spritesheet('player', 'assets/TurtleSpriteSheetSmooth.png', 82, 121);
        //game.load.image('header', 'assets/header.png');
        game.load.spritesheet('explode', 'assets/ExplosionSpriteSheet4.png', 74, 68);
        game.load.spritesheet('dai', 'assets/GreenGemSpriteSheet.png', 51, 38);
        game.load.spritesheet('bomb', 'assets/MeteorSpriteSheet.png', 55, 104);
        game.load.image('ground', 'assets/ground.jpg');
    },

    // Fuction called after 'preload' to setup the game 
    create: function () {

        // Set the physics system
        game.physics.startSystem(Phaser.Physics.ARCADE);
        this.background = this.game.add.sprite(0, 0, "background");
        this.background.width = game.width;
        this.background.height = game.height;

        // Display the player on the screen
        this.player = this.game.add.sprite(game.world.centerX, game.world.height - 165, 'player', 24);
        this.player.anchor.setTo(0.5, 0.5);
        /* [0,1,2,...,21] */
        framesright = [];
        for (i = 0; i < 24; i++) {
            framesright.push(i);
        }
        this.player.animations.add("walkleft", framesright, 50, true, true);
        framesleft = [];
        for (i = 25; i < 48; i++) {
            framesleft.push(i);
        }
        this.player.animations.add("walkright", framesleft, 50, true, true);
        this.player.animations.add("standing", [24], 15, true, true);


        // Add gravity to the player to make it fall
        game.physics.arcade.enable(this.player);
        this.player.body.gravity.y = 1000;
        this.player.body.collideWorldBounds = true;
        this.player.body.checkCollision.down = true;

        this.ground = this.game.add.sprite(0, game.world.height - 41, 'ground');
        this.ground.width = game.world.width;
        game.physics.arcade.enable(this.ground);
        this.ground.body.enable = true;
        this.ground.body.immovable = true;
        this.ground.body.allowGravity = false;

        this.cursor = this.game.input.keyboard.createCursorKeys();


        this.bombs = game.add.group();
        this.bombs.enableBody = true;
        this.bombs.physicsBodyType = Phaser.Physics.ARCADE;

        this.gems = game.add.group();
        this.gems.enableBody = true;
        this.gems.physicsBodyType = Phaser.Physics.ARCADE;

        this.explosions = game.add.group();
        this.explosions.enableBody = true;
        this.explosions.physicsBodyType = Phaser.Physics.ARCADE;

        game.time.events.loop(450, this.createBomb, this);

        //this.header = this.game.add.sprite(0, 0, "header");
        //this.header.width = this.game.width;

        var text = "Use left/right arrow to move,  avoid meteor shower";
        var style = { font: "13px Verdana", fill: "#fff", align: "center" };
        var t = game.add.text(this.game.world.centerX, 5, text, style);
        t.anchor.setTo(0.5, 0);

        this.labelScore = this.game.add.text(10, 10, "0", { font: "30px Arial", fill: "#ffffff" });
    },
    movePlayer: function () {
        if (this.cursor.left.isDown) {
            this.player.body.velocity.x = -450;
            //this.player.scale.x = -1;
            this.player.animations.play('walkleft', 50, true);
        }
        else if (this.cursor.right.isDown) {
            this.player.body.velocity.x = 450;
            //this.player.scale.x = 1;
            this.player.animations.play('walkright', 50, true);
        }
        else {
            this.player.body.velocity.x = 0;

            this.player.animations.play('standing', 15, true);
        }
    },

    // This function is called 60 times per second
    update: function () {

        game.physics.arcade.collide(this.player, this.ground);
        game.physics.arcade.collide(this.gems, this.ground);
        game.physics.arcade.overlap(this.player, this.gems, this.playerCollisionWithGem, null, this);
        game.physics.arcade.overlap(this.bombs, this.ground, this.bombCollisionWithGround, null, this);
        game.physics.arcade.collide(this.player, this.bombs, this.bombCollisionWithPlayer, null, this);
        game.physics.arcade.collide(this.player, this.explosions, this.explosionCollisionWithPlayer, null, this);
        this.movePlayer();
    },
    createBomb: function () {
        var x = this.player.x;
        var temp = Math.floor((Math.random() * 100) + 1);
        if (temp % 2 == 0) {
            x = Math.floor((Math.random() * game.world.width) + 1);
        }

        var bomb = this.bombs.create(x, 0, 'bomb', 1);
        bomb.anchor.setTo(0.5, 0.5);
        game.physics.arcade.enable(bomb);
        bomb.body.gravity.y = 50;
        bomb.body.acceleration.y = 2500;
        bomb.body.collideWorldBounds = true

        bomb.checkWorldBounds = true;
        bomb.outOfBoundsKill = true;
        bomb.animations.add('burning');
        bomb.animations.play('burning', 24, true);
    },
    playerCollisionWithGem: function (player, gem) {
        score += 1;
        this.labelScore.text = score;
        gem.kill();
    },

    bombCollisionWithGround: function (ground, bomb) {
        var xpl = this.explosions.create(bomb.x, bomb.y + (bomb.height / 2), 'explode');
        xpl.body.immovable = true;
        xpl.anchor.setTo(0.5, 1);
            bomb.kill();
        //  Here we add a new animation called 'walk'
        //  Because we didn't give any other parameters it's going to make an animation from all available frames in the 'mummy' sprite sheet
        xplanim = xpl.animations.add('xplode');

        //  And this starts the animation playing by using its key ("walk")
        //  30 is the frame rate (30fps)
        //  true means it will loop when it finishes
        xpl.animations.play('xplode', 24, false);
        xplanim.onComplete.add(function (sprite, animation) {
            sprite.kill();
            var gem = this.gems.create(sprite.x, sprite.y - sprite.height, "dai");
            gem.body.gravity.y = 1000;
            gem.anchor.setTo(0.5, 0.5);
            gem.animations.add("sparkle");
            gem.animations.play("sparkle", 24, true);
        }, this);
    },
    bombCollisionWithPlayer: function (player, bomb) {
        var xpl = this.game.add.sprite(player.x, player.y, 'explode');
        player.kill();
        bomb.kill();
        game.physics.arcade.enable(xpl);
        xpl.body.immovable = true;
        
        xpl.anchor.setTo(0.5, 1);
        xplanim = xpl.animations.add('xplode');
        xpl.animations.play('xplode', 24, false);
        xplanim.onComplete.add(function (sprite, animation) { sprite.kill(); }, this);
        xplanim.onComplete.add(function (sprite, animation) { sprite.kill(); this.restartGame(); }, this);
    },
    explosionCollisionWithPlayer: function (player, explosion) {
        explosion.kill();
        //var xpl = this.game.add.sprite(player.x, player.y, 'explode');
        //player.kill();
        //game.physics.arcade.enable(xpl);
        //xpl.body.immovable = true;
        //if (player.scale.x == -1) {
        //    xpl.anchor.setto(1, 0.5);
        //} else if (player.scale.x == 1) {
        //    xpl.anchor.setto(0, 0.5);
        //}
        //xplanim = xpl.animations.add('xplode');
        //xpl.animations.play('xplode', 20, false);
        //xplanim.oncomplete.add(function (sprite, animation) { sprite.kill(); this.restartgame(); }, this);
    },
    // Restart the game
    restartGame: function () {
        // Start the 'main' state, which restarts the game
        game.state.start('init');
    }
};

// Add and start the 'main' state to start the game
game.state.add('main', mainState);
game.state.add('init', initState);
game.state.start('init');