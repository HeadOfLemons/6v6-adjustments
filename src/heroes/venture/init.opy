#!mainFile "../../dev_main.opy"

#!include "heroes/venture/excavator.opy"
#!include "heroes/venture/clobber.opy"
#!include "heroes/venture/burrow.opy"
#!include "heroes/venture/tectonic_shock.opy"


rule "[venture/init.opy]: Venture":
    @Event eachPlayer
    @Condition eventPlayer.call_init
    @Condition eventPlayer.hero_setup == Hero.VENTURE

    newHero(ADJ_VENTURE_HEALTH, 0, 0)
    removeSelfHealing()

    setBaseDamage(eventPlayer, ADJ_VENTURE_DRILL_DASH_DAMAGE / OW2_VENTURE_DRILL_DASH_DAMAGE)
    eventPlayer.setKnockbackDealt(70)

    eventPlayer.call_init = false


rule "[venture/init.opy]: Correct Venture bonus shields":
    @Event eachPlayer
    @Condition eventPlayer.hero_setup == Hero.VENTURE
    @Condition eventPlayer.getMaxHealthOfType(Health.SHIELDS) >= 46
    
    eventPlayer.addHealthPool(Health.SHIELDS, 3.125, true, true)
    waitUntil(eventPlayer.getMaxHealthOfType(Health.SHIELDS) < 49, Math.INFINITY)
    removeHealthPool(getLastCreatedHealthPool())
