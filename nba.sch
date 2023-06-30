<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:ns uri="vse.cz:hosj03:nba" prefix="n"/>
    
    <sch:pattern>
        <sch:title>Kontrola sezóny</sch:title>
        <sch:rule context="n:zapas">
            <sch:report test="(xs:date(n:datum) gt xs:date(../@sezonaZacatek)) and
                (xs:date(n:datum) gt xs:date(../@sezonaKonec))">
                S tímto datumem nepatří do této sezóny.
            </sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Kontrola začátku a konce sezóny</sch:title>
        <sch:rule context="n:zapasy">
            <sch:report test="xs:date(@sezonaZacatek) gt xs:date(@sezonaKonec)">
                Sezóna nemůže skončit dřív než začne.
            </sch:report>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Kontrola jména hostů a domácích</sch:title>
        <sch:rule context="n:zapas">
            <sch:assert test="(n:domaci = ../../n:tymy/n:tym[current()/n:domaci/@id = @id]/n:nazev or
                n:domaci = ../../n:tymy/n:tym[current()/n:domaci/@id = @id]/n:zkratka) and 
                (n:hoste = ../../n:tymy/n:tym[current()/n:hoste/@id = @id]/n:nazev or
                n:hoste = ../../n:tymy/n:tym[current()/n:hoste/@id = @id]/n:zkratka)">
                Název hostů nebo domácích neodpovídá názvu nebo zkratce daného id.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <sch:title>Kontrola skóre</sch:title>
        <sch:rule context="n:zapas">
            <sch:assert test=" n:vysledneSkore/n:domaci = 
                sum(n:prubeh/n:ctvrtina/n:kos[
                (n:tym = ../../../../../n:tymy/n:tym[current()/n:domaci/@id = @id]/n:nazev)
                or
                (n:tym = ../../../../../n:tymy/n:tym[current()/n:domaci/@id = @id]/n:zkratka)]
                /n:body)
                and
                n:vysledneSkore/n:hoste = 
                sum(n:prubeh/n:ctvrtina/n:kos[
                (n:tym = ../../../../../n:tymy/n:tym[current()/n:hoste/@id = @id]/n:nazev)
                or
                (n:tym = ../../../../../n:tymy/n:tym[current()/n:hoste/@id = @id]/n:zkratka)]
                /n:body)">
                Součet skóre z průběhu zápasu se nerovná výslednému skóre dle názvů.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
</sch:schema>