<?php
/**
 * @Project : Test Birchbox
 * @File    : index.php
 * @Author  : BOULFROY Nicolas
 */

session_start();

class User {
    /** @var string|null $username */
    private $username;

    /** @var int|null $age */
    private $age;

    /**
     * User constructor.
     *
     * @param string $username
     * @param string $age
     */
    public function __construct(string $username, int $age)
    {
        $this->username = $username;
        $this->age = $age;
    }

    /**
     * @return string
     */
    public function getUsername(): string
    {
        return $this->username;
    }

    /**
     * @return int
     */
    public function getAge(): int
    {
        return $this->age;
    }
}

if (isset($_POST['username']) and isset($_POST['age'])) {
    $_SESSION['users'][] = new User($_POST['username'], $_POST['age']);
}

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Test for Birchbox</title>
    </head>
    <body>
        <!-- Form -->
        <div>
            <form action="index.php" method="POST">
                <div>
                    <label for="username">Username:</label>
                    <input id="username" type="text" name="username"/>
                </div>
                <div>
                    <label for="age">Age:</label>
                    <input id="age" type="number" name="age" />
                </div>
                <div>
                    <button type="submit">Submit</button>
                </div>
            </form>
        </div>
        <br />
        <!-- Data stored in session -->
        <div>
        <table>
            <tr>
                <th>Username</th>
                <th>Age</th>
            </tr>
            <?php foreach ($_SESSION['users'] as $user): ?>
                <tr>
                    <td><?php echo($user->getUsername()) ?></td>
                    <td><?php echo($user->getAge()) ?></td>
                </tr>
            <?php endforeach ?>
        </table>
        </div>
    </body>
</html>
