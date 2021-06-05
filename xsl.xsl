<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" indent="yes"	omit-xml-declaration="yes"/>
    <xsl:key name="pers_name" match="tei:person" use="@xml:id"/>
    <xsl:key name="name" match="tei:name" use="@xml:id"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Codifica cartolina</title>
                <link rel="icon" type="image/png" href="img/mascot.png"/>
				<link rel="stylesheet" type="text/css" href="css/css.css" />
				<link rel="stylesheet" type="text/css" href="css/flickity.css" />
                <script src="js/jquery.js"/>
                <script src="js/flickity.js"/>
                <script src="js/js.js"/>
			</head>
			<body>
				<header>
                    <div>
                        <p>Progetto d'esame: <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type='main']"/></p>
                        <p>Le cartoline sono state codificate a <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition/tei:date"/> da
                        <strong><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name[@xml:id='MF']"/></strong> e 
                        <strong><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name[@xml:id='CA']"/></strong>.<br/>
                        Le cartoline sono state codificate da <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt/tei:name[@xml:id='TC']"/>.
                        I funzionari scientifici sono <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt/tei:name[@xml:id='GP']"/>
                        e <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt/tei:name[@xml:id='ES']"/>.
                        Il funzionario responsabile è <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:respStmt/tei:name[@xml:id='ER']"/>
                        </p>
                    </div>
				</header>   
                <main class="container-flickity">
                    <xsl:for-each select="tei:teiCorpus/tei:TEI">
                    
                        <section class="container-cartolina carousel-cell">
                            <!--foto cartolina-->
                            <div class="container-cartolina__img">
                                <xsl:apply-templates select="tei:facsimile/tei:surfaceGrp"/>
                            </div>
                            
                            <!--testo cartolina-->
                            <div class="container-cartolina__testo">
                                <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl"/>

                                <div class="container-cartolina__testo__fronte">
                                    <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='fronte']"/>
                                </div>

                                <div class="container-cartolina__testo__retro hide">
                                    <!--Trascrizione blocco indirizzi-->
                                    <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='contenuto_trascrizione']"/>
                                    <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='contenuto_trascrizione']/tei:opener"/>
                                    <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='stampe_cartolina']"/>
                                    <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='francobolli_timbri']"/>
                                    <xsl:apply-templates select="tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='francobolli_timbri']/tei:p/tei:stamp[@type='timbro']"/>
                                </div>

                                <div class="container-cartolina__testo__dati-tecnici hide">
                                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt"/>
                                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
                                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc"/>
                                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc"/>
                                    <xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson"/>
                                    <xsl:apply-templates select="tei:teiHeader/tei:profileDesc/tei:correspDesc"/>
                                </div>

                            </div>

                            <div class="cruscotto">
                                <input type="button" value="Fronte" class="bottone-front"/>
                                <input type="button" value="Retro" class="bottone-back"/>
                                <input type="button" value="Dati tecnici" class="data"/>
                            </div>
                        </section>
                    </xsl:for-each>
                </main>             
            </body>
        </html>
    </xsl:template>


    <!--__________________________________
    INIZIO TEMPLATES
    ___________________________________-->

    <!-- Template TITOLI cartoline -->
    <xsl:template match='tei:teiCorpus/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl'>
        <xsl:for-each select="tei:title">
            <h1>
                <xsl:value-of select="."/>
            </h1>
        </xsl:for-each>
    </xsl:template>

    <!-- Template che prende il testo del fronte delle cartoline-->
    <xsl:template match="//tei:div[@type='fronte']/tei:figure">
            <div class="container-cartolina__testo__fronte">
            <p>
                <xsl:value-of select="tei:figDesc"/>
            </p>

            <xsl:if test="tei:note != ''">
                <h3>Note</h3>
                <p class="container-cartolina__testo__fronte">
                    <xsl:value-of select="tei:note"/>
                </p>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="//tei:div[@type='fronte']/tei:head">
        <div class="container-cartolina__testo__fronte">
            <h3>Trascrizione</h3>
            <xsl:for-each select="tei:s">
                <p>
                    <xsl:value-of select="."/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>


    <!--Template per immagine fronte e retro-->
    <xsl:template match='tei:teiCorpus/tei:TEI/tei:facsimile/tei:surfaceGrp'>
        <xsl:apply-templates select="tei:surface[1]"/>
        <xsl:apply-templates select="tei:surface[2]"/>
    </xsl:template>

    <!--Trascrizione descrizione immagini fronte-->
    <xsl:template match='tei:text/tei:body/tei:div[@type="fronte"]'>
        <xsl:apply-templates select="tei:figure"/>
        <xsl:apply-templates select="tei:head"/>
    </xsl:template>

    <!--Trascrizione blocco indirizzi-->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='contenuto_trascrizione']">
        <div class="container-cartolina__testo__retro__blocco-dx">
            <h3>Trascrizione blocco indirizzi</h3>
            <xsl:for-each select="tei:ab[@type='blocco-destro']">
                <xsl:apply-templates />
            </xsl:for-each>
        </div>
    </xsl:template>

    <!--Trascrizione corpo cartolina-->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='contenuto_trascrizione']/tei:opener">
        <h3>Trascrizione corpo cartolina</h3>
        <p class="container-cartolina__testo__retro"><xsl:apply-templates /></p>
        <p><xsl:apply-templates select="../tei:p" /></p>
        <p><xsl:value-of select="../tei:closer/tei:signed"/></p>
    </xsl:template>

    <!--Trascrizione delle stampe a inchiostro sul retro della cartolina -->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='stampe_cartolina']">
        <div>
            <h3>Stampe sulla cartolina:</h3>
            <xsl:for-each select="tei:ab/tei:s">
                <p class="container-cartolina__testo__retro">
                    <xsl:value-of select="."/>
                </p >
            </xsl:for-each>
        </div>
    </xsl:template>


    <!--Trascrizione dei francobolli posti sul retro delle cartoline -->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='francobolli_timbri']">
         <div>
            <xsl:for-each select="tei:p/tei:stamp[@type='francobollo']">
                <h3>Francobollo</h3>
                <xsl:for-each select="tei:note">
                    <p class="container-cartolina__testo__retro">
                        <xsl:value-of select="."/>
                    </p>
                </xsl:for-each>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!--Trascrizione dei timbri posti sul retro della cartolina -->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:text/tei:body/tei:div[@type='retro']/tei:div[@type='francobolli_timbri']/tei:p/tei:stamp[@type='timbro']">
        <div>
            <xsl:for-each select=".">
                <h3>Timbro</h3>
                <p class="container-cartolina__testo__retro">
                    <xsl:apply-templates select="tei:mentioned"/>
                </p>
                <p class="container-cartolina__testo__retro">
                    <xsl:apply-templates select="tei:date"/>
                </p>
                <p class="container-cartolina__testo__retro">
                    <xsl:apply-templates select="tei:note"/>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>


    <!--Trascrizione delle informazioni di title statement di ogni cartolina (nome dei compilatori ed ente di appartenenza)-->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt">
        <div>
            <xsl:for-each select="tei:respStmt">
                <strong><xsl:value-of select="tei:resp"/></strong>
                <xsl:for-each select="tei:name/@ref">
                    <xsl:for-each select="key('name', .)">
                        <p><xsl:value-of select="."/></p>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!--Trascrizione dei dati tecnici di ogni cartolina, contenuti in publication statement -->
    <xsl:template match="tei:teiCorpus/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt">
        <div>
            <p>
                <strong>Luogo:</strong>
                <xsl:value-of select="concat(' ', tei:publisher)"/>
                <xsl:value-of select="concat(' ', tei:pubPlace)"/> 
            </p>
            <p>
                <strong>Distributore:</strong>
                <xsl:value-of select="concat(' ', tei:distributor)"/>
                <xsl:value-of select="concat(' ', tei:address/tei:addrLine, ' ')"/> 
                <strong>Sede di:</strong> <xsl:value-of select="concat(' ', tei:address/tei:placeName)"/>
            </p>
            <p><i><xsl:value-of select="tei:availability"/></i></p>
        </div>
    </xsl:template>

    <xsl:template match="tei:teiCorpus/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc">
        <div>
            <xsl:apply-templates select="tei:msIdentifier"/>
            <xsl:apply-templates select="tei:msContents"/>
        </div>
    </xsl:template>

    <xsl:template match="tei:teiCorpus/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc">
        <div>
            <xsl:apply-templates select="tei:objectDesc/tei:supportDesc"/>
            <xsl:apply-templates select="tei:handDesc"/>
           
        </div>
    </xsl:template>

    <xsl:template match="tei:teiCorpus/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:listPerson">
        <div>
            <h3>Persone coinvolte</h3>
            <xsl:for-each select="tei:person">
                <p><xsl:value-of select="concat(tei:persName, ' ')"/>
                    <xsl:choose>
                        <xsl:when test="tei:sex != ''">
                            <xsl:value-of select="concat('(',tei:sex, ')')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            (?)
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>

    <xsl:template match="tei:teiCorpus/tei:TEI/tei:teiHeader/tei:profileDesc/tei:correspDesc">
        <div>
            <p>
            <strong>Inviato da:</strong>
                <xsl:for-each select="tei:correspAction[@type='Inviata']/tei:persName/@ref">                    
                    <xsl:for-each select="key('pers_name', .)">
                        <xsl:value-of select="tei:persName"/>
                    </xsl:for-each>
                </xsl:for-each>
                <strong>Linguaggio usato:</strong><xsl:value-of select="concat(' ', ../tei:langUsage/tei:language)"/>
            </p>
        </div>
        <div>
            <p>
                <strong>Ricevuto da:</strong>
                <xsl:for-each select="tei:correspAction[@type='Ricevuta']/tei:persName/@ref">                    
                    <xsl:for-each select="key('pers_name', .)">
                            <xsl:value-of select="tei:persName"/>
                    </xsl:for-each>
                </xsl:for-each>
            </p>
        </div>
    </xsl:template>


<!--
        <profileDesc>
            <correspDesc>
                <correspAction type="Inviata">
                    <persName ref="#Giovanni"/>
                </correspAction>
                <correspAction type="Ricevuta">
                    <persName ref="#OT"/>
                </correspAction>
            </correspDesc>
            <langUsage>
                <language ident="it-IT">Italiano del Novecento</language>
            </langUsage>
        </profileDesc>
-->

    <!-- Template secondari-->

    <!-- Template che prende l'immagine del fronte delle cartoline-->
    <xsl:template match='//tei:surface[1]'>
        <div class="fronte">
            <xsl:element name="img">
                <xsl:attribute name="src">
                    <xsl:value-of select="tei:graphic/@url"/>
                </xsl:attribute>
            </xsl:element>
        </div>
    </xsl:template>

    <!-- Template che prende l'immagine del retro delle cartoline-->
    <xsl:template match='//tei:surface[2]'>
        <div class="retro hide">
            <xsl:element name="img">
                <xsl:attribute name="src">
                    <xsl:value-of select="tei:graphic/@url"/>
                </xsl:attribute>
            </xsl:element>
        </div>
    </xsl:template>

    <xsl:template match="//tei:address">
        <p><xsl:apply-templates select="tei:persName"/></p>
        <p><xsl:apply-templates select="tei:addrLine"/></p>
    </xsl:template>

    <xsl:template match="//tei:dateLine">
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="//tei:p">
        <xsl:value-of select="."/>
    </xsl:template>


    <!-- Istruzioni per gli unclear -->
    <xsl:template match="//tei:date">
       Data: 
       <xsl:value-of select="."/>
       <xsl:if test="//tei:date = ''">
            &lt;<i>Illegibile</i>&gt;
       </xsl:if>
    </xsl:template>
    
    <xsl:template match="//tei:mentioned">
       Testo: 
        <xsl:if test="not(tei:term)">
            &lt;<i>Illegibile</i>&gt;
        </xsl:if>
       <xsl:for-each select='tei:term'>
        <xsl:value-of select="."/>
            <xsl:if test="//tei:unclear = ''">
                &lt;<i>Illegibile</i>&gt;
            </xsl:if>
       </xsl:for-each>
    </xsl:template>

    <xsl:template match="//tei:msIdentifier">
        <div>
            <h3>Descrizione del manoscritto</h3>
            <p><strong>Paese:</strong><xsl:value-of select="concat(' ', tei:country)"/></p>
            <p><strong>Città:</strong><xsl:value-of select="concat(' ', tei:settlement)"/></p>
            <p><strong>Conservato in:</strong><xsl:value-of select="concat(' ', tei:repository, ' ')"/><strong> Codice identificativo:</strong><xsl:value-of select="concat(' ', tei:idno)"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="//tei:msContents">
        <div>
            <p><strong>Tipo di documento:</strong><xsl:value-of select="concat(' ', tei:summary)"/></p>
            <p><strong>Lingua/e:</strong><xsl:value-of select="concat(' ', tei:textLang)"/></p>
        </div>
    </xsl:template>

    <xsl:template match="//tei:objectDesc/tei:supportDesc">
        <div>
            <h3>Descrizione oggetto</h3>
            <p><strong>Tipo di oggetto:</strong><xsl:value-of select="concat(' ', tei:support/tei:objectType)"/></p>
            <p><strong>Materiale:</strong><xsl:value-of select="concat(' ', tei:support/tei:material)"/></p>
            <xsl:apply-templates select="tei:support/tei:dimensions" />
            <p><strong>Condizione:</strong><xsl:value-of select="concat(' ', tei:condition)"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="//tei:support/tei:dimensions">
        <p>
            <strong>Dimensioni:</strong><xsl:value-of select="concat(' ', tei:width, @unit)"/>
            x
            <xsl:value-of select="concat(' ', tei:height, @unit)"/>
            </p>
    </xsl:template>

    <xsl:template match="//tei:handDesc">
        <div>
            <h3>Note riguardo i contenuti scritti</h3>
            <xsl:for-each select="tei:handNote">
                <p><xsl:value-of select="."/></p>
            </xsl:for-each>
        </div>
    </xsl:template>

</xsl:stylesheet>