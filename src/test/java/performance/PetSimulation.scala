package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration.DurationInt

class PetSimulation extends Simulation {

  val protocol = karateProtocol(
    "/v2/user/{username}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val createUser = scenario("Petswagger Scenarios")
    .exec(karateFeature("classpath:petswagger/features/pet-example-1.feature"))

  setUp(
    createUser.inject(
      atOnceUsers(10),
      nothingFor(4 seconds),
      constantUsersPerSec(1) during (3 seconds)
    ).protocols(protocol)
  )
}