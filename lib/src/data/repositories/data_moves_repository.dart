import '../../domain/entities/move.dart';

import '../../domain/repositories/moves_repository.dart';

class DataMovesRepository extends MovesRepository {
  List<Move> moves;
  static DataMovesRepository _instance = DataMovesRepository._internal();
  DataMovesRepository._internal() {
    moves = List<Move>();
    moves.addAll([
      Move('Sombrero', 'Key Times: 1 * 8', '''Begins with: From Open Position, Vacilala con la Mano (right hand)

Hand holds: Right hand to Right hand, Left hand grabs Right hand, Followers Left arm ends on Leaders Left shoulder keeping the hand holds 

Ends with: “crossed hand ending”, like in El Uno.''', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
      Move('El Uno', 'Key Times: 3 * 8', '''Begins with: Open Position, Guapea, Right hand to Left hand
      
Hand holds: Right hand to Left hand, then pull Followers right arm behind her back twice, then enshufela arms on top twice

Ends with: bounce effect, Sombrero end position''', 'https://www.youtube.com/embed/Imw-H_bQb1c', 2),
      Move('El Dos', 'Key Times: 4 * 8', '''Begins with: Open Position, enshufela
      
Hand holds: Right hand to Left hand, then Leader pulls Follower behind his back twice, then enshufela arms on top twice

Ends with: Sombrero''', 'https://www.youtube.com/embed/WQXHNy77fgY', 2),
      Move('Montana', 'Key Times: 3 * 8', '''Begins with: same as Sombrero, from Open Position, Vacilala con la Mano (right hand)
      
Hand holds: Right hand to Right hand, Left hand grabs Right hand, end arms crossed Leaders left arm on top, pull with enshufela to end arms crossed Leaders right arm on top, leader right turn arms on top

Ends with: bounce effect, di le que no''', 'https://www.youtube.com/embed/A8MCYkUZRXk', 2),
      Move('Coca Cola', 'Key Times: 2 * 8', '''Begins with: Enshufela then di le que no
      
Hand holds: while doing di le que no, place Left arm in front of Followers on Right shoulder and pull

Ends with: Move back to reach di le que no's position and end with di le que no''', 'https://www.youtube.com/embed/C8N58KGoGyw', 2),
      Move('Kentucky', 'Key Times: 2 * 8', '''Begins with: Closed Position
      
Hand holds: Enshufela by pulling left hand, right arm ends behind Followers, change positions again Left hand ends behind Followers still holding right hand, Leader right turn

Ends with: Di le que no''', 'https://www.youtube.com/embed/6CXoxcQ3bAk', 2),
      Move('Tour Magico', 'Key Times: 1 * 8', '''Begins with: Closed Position
      
Hand holds: Closed hand holding, then Followers right turn, then Leaders left turn

Ends with: Closed position''', 'https://www.youtube.com/embed/mG_J0xQy8O8', 2),
      Move('Vacilala Vacilense', 'Key Times: 1 * 8', '''Begins with: Open Position
      
Hand holds: Left hand to Right hand, pull and release the hand to indicate Followers to perform Right turn

Ends with: Di le que no''', 'https://www.youtube.com/embed/Obl71WOOjJ4', 2),
      Move('Enchufela Doble', 'Key Times: 2 * 8', '''Begins with: Open or Closed position, Left hand to Right hand
      
Hand holds: Left hand to Right hand, pull to change positions but Leaders put Right arm behind Followers back and then pushes, perform twice

Ends with: Closed Position''', 'https://www.youtube.com/embed/r2KcM4wxOC4', 2),
      Move('Exhibela Doble', 'Key Times: 2 * 8', '''Begins with: Closed Position
      
Hand holds: Leaders lifts up its left arm then pushes followers back with Right hand, then Leaders pull left to go back in closed position 

Ends with: Closed Position''', 'https://www.youtube.com/embed/o4nkV-0Ts9Q', 2),
    ]);
  }
  factory DataMovesRepository() => _instance;

  @override
  Future<List<Move>> getAllMoves() async {
    return moves;
  }

  /*
   moves.addAll([
      Move('Sombrero', 'Key Times: 1 * 8', '''Start a Vacilala con la Mano from a right to right hold, in which the right arms are above the left arms. On 5-6-7 finish with the “crossed hand ending”, like in El Uno.''', 'https://www.youtube.com/embed/AqnNTeRs2Pw', 1),
      Move('El Uno', 'Key Times: 3 * 8', '''Start with a right to right hold of the hands, Switch On 7 if coming from Guapea.
Perform the Back Rocks basic step. On the 1st count, On 1 step in place, on 2-3 move forward. Leader gently bends the follower's right arm behind her back, and grabs the left hand with his left hand.
On 5 step in place, and on 6-7 do the same as before, just to the opposite side, meaning the left arm is the one that is going to bend behind the followers back.
On the 2nd count do exactly the same as on the 1st count.
On the 3rd count do an Enchufala, with both arms going over the followers head, on 1-2-3. On 5-6-7 leader places the arms on top of the head, with the right arm going on the follower's right shoulder, and the left arm going on the leader's left shoulder. This is known as the “crossed hand ending”.''', 'https://www.youtube.com/embed/Imw-H_bQb1c', 2),
      Move('El Dos', 'Key Times: 4 * 8', '''Perform an Enchufala using right to right hold on 1-2-3, and on 5-6-7 the leader goes to the right of the follower, like in Abrazala, and folds its right arm behind its back, while grabbing the followers left hand with its left hand. An alternative popular way is to start with left to right hold and switch to left right hold around the 6-7 beats when the leader is infront of the follower.
On the 2nd count, from this position, do a whole count of the Back Rocks step.
On the 3rd count, perform Back Rocks on 1-2-3, and while doing the step on 5-6-7, leader goes under its right arm, and the couple is in Guapea position.
From here, on the 4th count, perform a Sombrero.''', 'https://www.youtube.com/embed/WQXHNy77fgY', 2),
      Move('Montana', 'Key Times: 3 * 8', '''This move is exactly like El Dedo, just from a right to right above left to left hold.
Start the move with a Sombrero on 1-2-3, and change places with a Alarde, or an Engancha with a left then right turn, on 5-6-7.
The 2nd count is an Enchufala con Vuelta, with a position change between the leader and the follower during the Vuelta.
The 3rd count is an Enchufala that ends with the crossed hands ending.''', 'https://www.youtube.com/embed/A8MCYkUZRXk', 2),
      Move('Coca Cola', 'Key Times: 2 * 8', '''This move consists of 1.5 traveling turns to the left, and a Dile Que No.

The move starts from Dile Que No position (regardless of the Rueda). Start a Dile Que No on 1-2-3 of the 1st count.
On 5 leader leads follower to start a turn to the left, which continues on the 6-7-8-1, making it a total of 1.5 turns left.
The 2nd count starts with a Dile Que No that is much larger than the ordinary one, because the follower is somewhat to the left of the leader, but must be brought back to Guapea position. Proceed with the Dile Que No until you get to Guapea position. This big Dile Que No movement is similiar to Dame Abajo''', 'https://www.youtube.com/embed/C8N58KGoGyw', 2),
      Move('Kentucky', 'Key Times: 2 * 8', '''Start with an Enchufala Doble, with the leaders left arm going over the followers head on 1-2-3, and the right arm staying low, and on the 5-6-7 the right arm goes high, and left arm moves to followers neck, near its right shoulder.
On 1-2-3 of the 2nd count, perform an Enchufala during which the right arm goes over the followers head, and the left stays on its neck. On 5-6-7 the leader performs a Vuelta, during which its right arm moves to its left shoulder, and thus the leader “wraps” itself with its right arm.''', 'https://www.youtube.com/embed/6CXoxcQ3bAk', 2),
      Move('Tour Magico', 'Key Times: 1 * 8', '''While being in closed position, lead a left turn on 1-2-3 then the leader must go under its left arm then perform a turn to the left, ending in front of the follower in closed position.''', 'https://www.youtube.com/embed/mG_J0xQy8O8', 2),
      Move('Vacilala Vacilense', 'Key Times: 1 * 8', '''Vacilala is an important move and step that many moves are based on in Salsa Cubana. The Vacilala steps are taught in different variations that all bring a similar result. Below is the most standardized version, which we believe to be the best:

Leader:
On 1 there must be a Contra. This is achieved by giving the follower a slight pull inside on the 7th beat of the previous count.
On 2 The leader turns his left hand to the left (the follower's right) and leaves the hand alone.
Throughout the move, the leader goes forward-forward-forward for 1-2-3, and then Back and towards the follower on the 5-6-7 (Similarly to Enchufala)''', 'https://www.youtube.com/embed/Obl71WOOjJ4', 2),
      Move('Enchufela Doble', 'Key Times: 2 * 8', '''Enchufala Doble is a very similar move to Enchufala and it seems like an Enchufala, backwards Enchufala and then Enchufala again. The steps are utilizing mostly the Back Rocks steps.

The Steps:
1. On 1 2 3 an Enchufala is preformed with Back Rocks steps. On the 3 the leader places his right hand on his follower's left shoulder (does not block yet).
2. On 5 the leader blocks and pushes with his right hand the follower's back so she would turn with her left shoulder forward using Back Rocks (a clockwise turn). Simultaneously the leader is turning his partner with the the left hand in a clockwise motion, and continues with the Back Rocks steps. This part seems like you are regretting the Enchufala and trace it back since now you are on the same place you started.
3. On the next bar a normal Enchufala is preformed.''', 'https://www.youtube.com/embed/r2KcM4wxOC4', 2),
      Move('Exhibela Doble', 'Key Times: 2 * 8', '''This is the Cuban way to do a right turn of the follower. To start an Exhibela you would usually get to Dile Que No position, but you can also start it from Guapea position.
On 1 the leader slightly pushes the follower back and to the right. This is the lead. Follower steps in place (or slightly back) On 1 with right foot.
On 2 follower goes forward.
On 3 folloswer steps with right foot forward. Some followers choose to place the foot rotated a bit to the right.
On 5 follower steps forward. Some followers already choose to face to the right.
On 6 follower pivots toward the leader with the right foot. If far away it is possible to step towards him.
On 7 follower closes the circle back to the partner, returning to the starting position of Closed Position.
The follower should imagine walking around something in a circle.

Perform twice.
''', 'https://www.youtube.com/embed/o4nkV-0Ts9Q', 2),
      Move('Cementario', 'Key Times: 4 * 8', 'The Cementario move.', 'https://www.youtube.com/embed/itBdgUz4hMA', 3),
      Move('Nudo', 'Key Times: 2 * 8', '''Start with a variation of Vacilala con la Mano with both hands held in Parallel position. The Leader's right arm (follower's left) wraps around the follower's head by the 3rd beat. Only then by the 5th beat, the left arm joins above the follower's head, and around the back of the leader. By the end of the count, the follower should be ready to walk around the leader though his back.
On the 2nd count, the leader leads the follower to walk around him while he is doing Basic Steps. On 1 the right arm goes through the back to the right and in front of the leader. On 3 Engancha with the left arm. On 7 wrap the right arm (follower's left ) around her head again, placing the hand on her right shoulder. By the end of the count, the follower should be ready for a Dile Que No.''', 'https://www.youtube.com/embed/cUHjbSiQU9Y', 3),
    ]);
  */
}
