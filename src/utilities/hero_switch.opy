#!mainFile "../dev_main.opy"

playervar hero_switch_pvar
#!defineMember _last_hero_played hero_switch_pvar[0]
#!defineMember _hero_switched hero_switch_pvar[1]
#!defineMember _hero_id hero_switch_pvar[2]

#!define switchedHero(player) player._hero_switched


rule "[utilities/hero_switch.opy]: detect hero switch":
    @Event eachPlayer
    @Condition eventPlayer._last_hero_played != eventPlayer.getCurrentHero()
    
    eventPlayer._hero_switched = true
    wait()
    eventPlayer._last_hero_played = eventPlayer.getCurrentHero()
    # eventPlayer._hero_id = heroID(eventPlayer._last_hero_played)
    eventPlayer._hero_switched = false


rule "[utilities/hero_switch.opy]: Initialize hero on hero switch":
    @Event eachPlayer
    @Condition switchedHero(eventPlayer)

    waitUntil(not switchedHero(eventPlayer), Math.INFINITY)
    eventPlayer.hero_setup = eventPlayer.getCurrentHero()
    resetHero()
    eventPlayer.call_init = true


rule "[utilities/hero_switch.opy]: reset ult charge on hero switch":
    @Event eachPlayer
    @Condition switchedHero(eventPlayer)

    resetUltCharge()
