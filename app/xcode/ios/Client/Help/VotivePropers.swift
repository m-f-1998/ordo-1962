//
//  VotiveMasses.swift
//  ordo-1962
//
//  Created by Matthew Frankland on 30/12/2023.
//

import Foundation
import OrderedCollections
var votive_propers : OrderedDictionary = [
    "Our Lord Jesus Christ, Supreme and Eternal Priest - 1st Thursday" : CelebrationData (
        rank : 4,
        title : "Our Lord Jesus Christ, The High Priest",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 109:4*\nThe Lord hath sworn, and He will not repent: Thou art a priest for ever according to the order of Melchisedech. (P.T. Alleluia, alleluia.)\n*Ps 109:1*\nThe Lord said to my Lord: Sit thou at my right hand.\nGlory be to the Father...\nThe Lord hath sworn, and He will not repent: Thou art a priest for ever according to the order of Melchisedech. (P.T. Alleluia, alleluia.)",
                latin : "*Ps 109:4*\nJurávit Dóminus, et non pœnitébit eum: Tu es sacérdos in ætérnum secúndum órdinem Melchísedech. (T.P. Allelúja, allelúja.)\n*Ps 109:1*\nDixit Dóminus Dómino meo: Sede a dextris meis.\nGlória Patri...\nJuravit Dóminus, et non pœnitébit eum: Tu es sacérdos in ætérnum secúndum órdinem Melchísedech. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, who for the glory of Thy Majesty and the salvation of the human race, didst establish Thine only begotten Son as the supreme and eternal Priest: grant that those He has chosen to dispense His mysteries may prove loyal in carrying out the ministry they have received.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Deus, qui ad majestátis tuæ glóriam et géneris humáni salútem, Unigénitum tuum summum atque ætérnum constituísti Sacerdótem: præsta; ut quos minístros et mysteriórum suórum dispensatóres elégit, in accépto ministério adimpléndo fídéles inveniántur.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Heb 5:1-11*\nBrethren: Every high priest taken from among men, is ordained for men in the things that appertain to God, that he may offer up gifts and sacrifices for sins; who can have compassion on them that are ignorant and err: because he himself also is compassed with infirmity. And therefore he ought, as for the people, so also for himself, to offer for sins. Neither doth any man take the honor to himself, but he that is called by God, as Aaron was. So Christ also did not glorify himself, that He might be made a high priest: but He that said unto Him: Thou art my Son, this day have I begotten Thee. As He saith also in another place: Thou art a priest for ever, according to the order of Melchisedech. Who in the days of his flesh, with a strong cry and tears, offering up prayers and supplications to Him that was able to save Him from death, was heard for His reverence. And whereas indeed He was the Son of God, He learned obedience by the things which He suffered: and being consummated, He became, to all that obey Him, the cause of eternal salvation. Called by God a high priest according to the order of Melchisedech. Of whom we have to say, and hard to be intelligibly uttered.",
                latin : "*Heb 5:1-11*\nFratres: Omnis Póntifex ex homínibus assúmptus, pro homínibus constituítur in iis, quæ sunt ad Deum, ut ófferat dona, et sacrifícia pro peccátis: qui condolére possit iis, qui ignórant, et errant: quóniam et ipse circúmdatus est infirmitáte: et proptérea debet, quemádmodum pro pópulo ita étiam et prosemetípso offére pro peccátis. Nec quisquam sumit sibi honórem. sed qui vocátur a Deo, tamquam Aaron. Sic et Christus non semetípsum clarificávit ut póntifex fierret, sed qui locútus est ad eum: Fílius meus es tu: ego hódie génui te. Quemádmodum et in álio loco dicit: Tu es Sacérdos in ætérnum secundum órdinem Melchísedech. Qui in diébus carnis suæ preces supplicationésque ad eum, qui possit illum salvum fácere a morte, cum clamóre válido et lácrymis ófferens, exaudítus est pro sua reveréntia. Et quidem cum esset Fílius Dei didicit ex iis, quæ passus est obediéntiam: et consummátus, factus est ómnibus obtemperántibus sibi, causa salútis ætérnæ, appellátus a Deo póntifex juxta órdinem Melchísedech. De quo nobis grandis sermo, et ininterpretábilis ad dicéndum."
            ),
            PropersData (
                title : "Gradual",
                english : "*Lk 4:18*\nThe Spirit of the Lord is upon me, wherefore He hath anointed me: he hath sent me to preach the Gospel to the poor, to heal the contrite of heart.",
                latin : "*Lk 4:18*\nSpiritus Dómini super me, propter quod unxit me: Evangelizáre paupéribus misit me, sanáre contrítos corde."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Heb 7:24*\nAlleluia, alleluia. But for that Jesus continueth forever, hath an everlasting priesthood. Alleluia.",
                latin : "*Heb 7:24*\nAllelúja, allelúja. Jesus autem eo quod máneat in ætérnum, sempitérnum habet sacerdótium. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 9:34-36*\nArise, O Lord God, let Thy hand be exalted: forget not the poor. See, for Thou considerest labor and sorrow: To Thee is the poor man left: Thou wilt be a helper to the orphan.",
                latin : "*Ps 9:34-36*\nExsúrge, Dómine Deus, exaltétur manus tua: ne obliviscáris páuperum. Vide quóniam tu labórem et dolórem consíderas: Tibi derelíctus est pauper: órphano tu eris adjutor."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Heb 7:24*\nAlleluia, alleluia. But for that Jesus continueth forever, hath an everlasting priesthood. Alleluia.\n*Lk 4:18*\nThe Spirit of the Lord is upon me, wherefore He hath anointed me to preach the gospel to the poor, He hath sent me to heal the contrite of heart. Alleluia.",
                latin : "*Heb 7:24*\nAllelúja, allelúja. Jesus autem eo quod máneat in ætérnum, sempitérnum habet sacerdótium. Allelúja.\n*Lk 4:18*\nSpíritus Dómini super me: propter quod unxit me, evangelizáre paupéribus misit me, sanáre contrítos corde. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 22:14-20*\nAt that time: Jesus sat down, and the twelve Apostles with Him. And He said to them: With desire I have desired to eat this pasch with you, before I suffer. For I say to you, that from this time I will not eat it, till it be fulfilled in the kingdom of God. And having taken the chalice, He gave thanks, and said: Take, and divide it among you: for I say to you, that I will not drink of the fruit of the vine, till the kingdom of God come. And taking bread, He gave thanks, and brake; and gave to them, saying: This is my Body, which is given for you. Do this for commemoration of me. In like manner the chalice also, after he had supped saying: This is the chalice, the new testament in my Blood, which shall be shed for you.",
                latin : "*Lk 22:14-20*\nIn illo témpore: Discúbuit Jesus, et duódecim Apóstoli cum eo. Et ait illis: Desidério desiderávi hoc Pascha manducáre vobíscum, ántequam pátiar. Dico enim vobis, quia ex hoc non manducábo illud, donec impleátur in regno Dei. Et accépto cálice, grátias egit, et dixit: Accípite, et divídite inter vos. Dico enim vobis, quod non bibam de generatióne vitis, donec regnum Dei véniat. Et accépto pane, grátias egit, et fregit,et dedit eis, dicens: Hoc est Corpus meum, quod pro vobis datur, hoc fácite in meam commemmoratiónem. Simíliter et cálicem, postquam cœnávit, dicens: Hic est calix novum testaméntum in sánguine meo, qui pro vobis fundétur."
            ),
            PropersData (
                title : "Offertory",
                english : "*Heb 10:12-14*\nChrist offering one sacrifice for sins, for ever sitteth on the right hand of God: For by one oblation He hath perfected for ever them that are sanctified.",
                latin : "*Heb 10:12-14*\nChristus unam pro peccátis ófferens hóstiam, in sempitérnum sedet in déxtera Dei: una enim oblatióne consummávit in ætérnum sanctificátos."
            ),
            PropersData (
                title : "Secret",
                english : "O Lord, may our Mediator Jesus Christ make these offerings agreeable to Thee: and along with Himself may He offer us to Thee as a thank-offering: Who lives and reigns with Thee in the unity of the Holy Spirit, God, forever and ever.",
                latin : "Hæc múnera, Dómine, mediátor noster Jesus Christus Tibi reddat accépta: et nos, una secum, hóstias tibi gratas exhíbeat:\nQui tecum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*1 Cor 11:24-25*\nThis Body which shall be delivered for you; this chalice is the new testament in my blood saith the Lord: this do for the commemoration of me. (P.T. Alleluia.)",
                latin : "*1 Cor 11:24-25*\nHoc Corpus, quod pro vobis tradétur: hic calix novi testaménti est in meo sánguine, dicit Dóminus: hoc fácite, quotiescúmque súmitis, in meam commemoratiónem. (T.P.Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "We beseech Thee, O Lord, may the divine host which we have offered up and received, quicken us; that, bound to Thee by an eternal love, we may bear fruit that will abide forever.\nThrough our Lord...",
                latin : "Vivificet nos, quæsumus Dómine, divína quam obtúlimus et súmpsimus hóstia: ut perpétua Tibi caritáte conjúncti, fructum, qui semper máneat, afferámus.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "The Most Sacred Heart of Jesus - 1st Friday" : CelebrationData (
        rank : 4,
        title : "The Sacred Heart",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 32:11,19*\nThe thoughts of His Heart are from generation to generation: to save their souls from death, and to feed them in famine. Rejoice in the Lord, O ye just: praise becometh the upright.\nGlory be to the Father...\nThe thoughts of His Heart are from generation to generation: to save their souls from death, and to feed them in famine.",
                latin : "*Ps 32:11,19*\nCogitatiónes Cordis ejus in generatiónes et generatiónem: ut éruat a morte ánimas eórum et alat eos in fame. Exsultáte, justi, in Dómino, rectos decet collaudátio.\nGlória Patri...\nCogitatiónes Cordis ejus in generatiónes et generatiónem: ut éruat a morte ánimas eórum et alat eos in fame."
            ),
            PropersData (
                title : "Collect",
                english : "O God, who in the Heart of Thy Son, wounded by our sins, dost mercifully vouchsafe to bestow upon us the boundless treasures of Thy love: grant, we beseech Thee, that we who now render Him the service of our devotion and piety, may also fulfill our duty of worthy satisfaction.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Deus, qui nobis in Corde Fílii tui, nostris vulneráto peccátis, infinítos dilectiónis thesáuros misericórditer largíri dignáris: concéde, quǽsumus; ut, illi devótum pietátis nostræ præstántes obséquium, dignæ quoque satisfactiónis exhibeámus offícium.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Eph 3:8-19*\nBrethren, To me, the least of all the Saints, is given this grace, to preach among the Gentiles the unsearchable riches of Christ: and to enlighten all men, that they may see what is the dispensation of the mystery which hath been hidden from eternity in God, who created all things: that the manifold wisdom of God may be made known to the principalities and powers in heavenly places through the Church, according to the eternal purpose which He made in Christ Jesus our Lord: in whom we have boldness and access with confidence by the faith of Him. For this cause I bow my knees to the Father of our Lord Jesus Christ, of whom all paternity in heaven and earth is named, that He would grant you according to the riches of His glory, to be strengthened by His Spirit with might unto the inward man, that Christ may dwell by faith in your hearts: that, being rooted and grounded in charity, you may be able to comprehend with all the Saints, what is the breadth and length, and height and depth: to know also the charity of Christ which surpasseth all knowledge, that you may be filled unto all the fullness of God.",
                latin : "*Eph 3:8-19*\nFratres: Mihi, ómnium sanctórum mínimo, data est grátia hæc, in géntibus evangelizáre investigábiles divítias Christi, et illumináre omnes, quæ sit dispensátio sacraménti abscónditi a saeculis in Deo, qui ómnia creávit: ut innotéscat principátibus et potestátibus in cæléstibus per Ecclésiam multifórmis sapiéntia Dei, secúndum præfinitiónem sæculórum, quam fecit in Christo Jesu, Dómino nostro, in quo habémus fidúciam et accéssum in confidéntia per fidem ejus. Hujus rei grátia flecto génua mea ad Patrem Dómini nostri Jesu Christi, ex quo omnis patérnitas in cælis et in terra nominátur, ut det vobis, secúndum divítias glóriæ suæ, virtúte corroborári per Spíritum ejus in interiórem hóminem, Christum habitáre per fidem in córdibus vestris: in caritáte radicáti et fundáti, ut póssitis comprehéndere cum ómnibus sanctis, quæ sit latitúdo, et longitúdo, et sublímitas, et profúndum: scire étiam supereminéntem sciéntiæ caritátem Christi, ut impleámini in omnem plenitúdinem Dei."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 24:8-9*\nThe Lord is sweet and righteous: therefore He will give a law to sinners in the way. He will guide the mild in judgment: He will teach the meek His ways.",
                latin : "*Ps 24:8-9*\nDulcis et rectus Dóminus: propter hoc legem dabit delinquéntibus in via. Díriget mansúetos in judício, docébit mites vias suas."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Matt 11:29*\nAlleluia, alleluia. Take my yoke upon you and learn from Me, because I am meek and humble of Heart: and you shall find rest to your souls. Alleluia.",
                latin : "*Matt 11:29*\nAllelúja, allelúja. Tóllite iugum meum super vos, et díscite a me, quia mitis sum et húmilis Corde, et inveniétis réquiem animábus vestris. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 19:31-37*\nAt that time: The Jews (because it was the Parasceve), that the bodies might not remain upon the cross on the Sabbath day (for that was a great Sabbath day) besought Pilate that their legs might be broken, and that they might be taken away. The soldiers therefore came: and they broke the legs of the first, and of the other that was crucified with Him. But after they were come to Jesus, when they saw that He was already dead they did not break His legs. But one of the soldiers with a spear opened His side, and immediately there came out blood and water. And he that saw it hath given testimony: and his testimony is true. And he knoweth that he saith true, that you may believe. For these things were done that the Scripture might be fulfilled: You shall not break a bone of Him. And again another Scripture saith: They shall look on Him whom they pierced.",
                latin : "*Jn 19:31-37*\nIn illo témpore: Judǽi, quóniam Parascéve erat, ut non remanérent in cruce córpora sábbato, erat enim magnus dies ille sábbati, rogavérunt Pilátum, ut frangeréntur eórum crura, et tolleréntur. Venérunt ergo mílites: et primi quidem fregérunt crura et alteríus, qui crucifíxus est cum eo. Ad Jesum autem cum veníssent, ut vidérunt eum jam mórtuum, non fregérunt ejus crura, sed unus mílitum láncea latus ejus apéruit, et contínuo exívit sanguis et aqua. Et qui vidit, testimónium perhíbuit: et verum est testimónium ejus. Et ille scit quia vera dicit, ut et vos credátis. Facta sunt enim hæc ut Scriptúra implerétur: Os non comminuétis ex eo. Et íterum alia Scriptúra dicit: Vidébunt in quem transfixérunt."
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 68:21*\nMy Heart hath expected reproach and misery; and I looked for one that would grieve together with me, but there was none: and for one that would comfort me, and I found none.",
                latin : "*Ps 68:21*\nImpropérium exspectávi Cor meum et misériam: et sustínui, qui simul mecum contristarétur, et non fuit: consolántem me quæsívi, et non invéni."
            ),
            PropersData (
                title : "Secret",
                english : "Have regard, we beseech Thee, O Lord, to the inexpressible love of the Heart of Thy beloved Son: so that what we offer may be a gift acceptable to Thee, and an expiation for our offenses.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Réspice, quǽsumus, Dómine, ad ineffábilem Cordis dilécti Fílii tui caritátem: ut quod offérimus sit tibi munus accéptum et nostrórum expiátio delictórum.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Preface of the Sacred Heart",
                english : "It is truly meet and just, right and for our salvation, that we should at all times and in all places give thanks to Thee, holy Lord, Father almighty, eternal God: Whose will it was that Thine only-begotten Son, while hanging on the Cross, should be pierced by the soldier’s lance: that the Heart thus opened should, as from a well of divine bounty, pour over us streams of mercy and of grace: and that the Heart which never ceased to burn with love for us, should be for the devout a haven of rest and for the penitent an open refuge of salvation. And therefore with Angels and Archangels, with Thrones and Dominations, and with all the hosts of the heavenly army, we sing a hymn to Thy glory, evermore saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Qui Unigénitum tuum, in Cruce pendéntem, láncea mílitis transfígi voluísti: ut apértum Cor, divínæ largitátis sacrárium, torréntes nobis fúnderet miseratiónis et grátiæ: et, quod amóre nostri flagráre numquam déstitit, piis esset réquies et pœniténtibus patéret salútis refúgium. Et ídeo cum Ángelis et Archángelis, cum Thronis et Dominatiónibus cumque omni milítia cæléstis exércitus hymnum glóriæ tuæ cánimus, sine fine dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Jn 19:34*\nOne of the soldiers with a spear opened His side, and immediately there came out blood and water.",
                latin : "*Jn 19:34*\nUnus mílitum láncea latus ejus apéruit, et contínuo exívit sanguis et aqua."
            ),
            PropersData (
                title : "Postcommunion",
                english : "May Thy holy Mysteries, O Lord Jesus, impart to us divine fervor: wherein we may taste the sweetness of Thy most loving Heart, and learn to despise what is earthly and love what is heavenly: Who lives and reigns with God the Father in the unity of the Holy Spirit, God, forever and ever.",
                latin : "Prǽbeant nobis, Dómine Jesu, divínum tua sancta fervórem: quo dulcíssimi Cordis tui suavitáte percépta; discámus terréna despícere, et amáre cæléstia: Qui vivis et regnas, cum Deo Patre in unitáte Spíritus Sancti, Deus, per ómnia sǽcula sæculórum."
            )
        ],
        commemorations : []
    ),
    "The Immaculate Heart of Our Lady - 1st Saturday" : CelebrationData (
        rank : 4,
        title : "The Immaculate Heart",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Heb 4:16*\nLet us come with confidence to the throne of grace, that we may obtain mercy, and may find grace in seasonable aid. (P. T. Alleluia, alleluia.)\n*Ps 44:2*\nMy heart hath uttered a good word: I speak my works to the King.\nGlory be to the Father...\nLet us come with confidence to the throne of grace, that we may obtain mercy, and may find grace in seasonable aid. (P. T. Alleluia, alleluia.)",
                latin : "*Heb 4:16*\nAdeámus cum fidúcia ad thronum grátiæ, ut misericórdiam consequámur, et grátiam inveniámus in auxílio opportúno. (T.P. Allelúia, allelúia.)\n*Ps 44:2*\nEructávit cor meum verbum bonum: dico ego ópera mea Regi.\nGlória Patri...\nAdeámus cum fidúcia ad thronum grátiæ, ut misericórdiam consequámur, et grátiam inveniámus in auxílio opportúno. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "Almighty everlasting God, who in the heart of the blessed Virgin Mary didst prepare a dwelling worthy of the Holy Spirit; grant in Thy mercy, that we who with devout minds celebrate the festival of that immaculate heart, may be able to live according to Thine own Heart.\nThrough our Lord...",
                latin : "Omnípotens sempitérne Deus, qui in Corde beátæ Maríæ Vírginis dignum Spíritus Sancti habitáculum præparásti: concéde propítius; ut ejúsdem immaculáti Cordis festivitátem devóta mente recoléntes, secúndum cor tuum vívere valeámus.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Ecc 24:23-31*\nAs the vine I have brought forth a pleasant odor, and my flowers are the fruit of honor and riches. I am the mother of fair love, and of fear, and of knowledge, and of holy hope. In me is all grace of the way and of the truth, in me is all hope of life and of virtue. Come over to me, all ye that desire me, and be filled with my fruits; for my spirit is sweet above honey, and mine inheritance above honey and the honey-comb. My memory is unto everlasting generations. They that eat me, shall yet hunger; and they that drink me, shall yet thirst. He that hearkeneth to me shall not be confounded, and they that work by me shall not sin. They that explain me shall have life everlasting.",
                latin : "*Ecc 24:23-31*\nEgo quasi vitis fructifiávi suavitátem odóris: et flores mei, fructus honóris et honestátis. Ego mater pulchræ dilectiónis, et timóris, et agnitiónis, et sanctæ spei.In me grátia omnis viæ et veritátis: in me omnis spes vitæ et virtútis. Transíte ad me, omnes qui concupíscitis me, et a generatiónibus meis implémini. Spíritus enim meus super mel dulcis, et heréditas mea super mel et favum. Memória mea in generations sæculórum. Qui edunt me, adhuc esurient: et qui bibunt me, adhuc sítient. Qui audit me, non confundétur: et qui operántur in me, non peccábunt. Qui elúcidant me vitam ætérnam habébunt."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 12:6*\nMy heart shall rejoice in Thy salvation: I will sing to the Lord, Who giveth me good things: yea I will sing to the name of the Lord the most High.\n*Ps 44:18*\nThey shall remember Thy name throughout all generations. Therefore shall people praise thee for ever.",
                latin : "*Ps 12:6*\nExsultabit cor meum insalutári tuo: cantábo Dómino qui bona tríbuit mihi: et psallam nómini Dómini altíssimi.\n*Ps 44:18*\nMémores erunt nóminis tui in omni generatióne et generatiónem: proptérea pópuli confitebúntur tibi in ætérnum."
            ),
            PropersData (
                title : "Tract",
                english : "*Prov 8:32,35*\nNow therefore, children, hear me: Blessed are they that keep my ways. Hear instruction and be wise, and refuse it not. Blessed is the man that heareth me, and that watcheth daily at my gates and waiteth at the posts of my door. He that shall find me shall find life, and shall have salvation from the Lord.",
                latin : "*Prov 8:32,35*\nNunc ergo, fílii, audíte me Beáti, qui custódiunt via meas. Audíte disciplínam et estóte sapiéntes, et nolíte abícere eam. ℣. Beátus homo qui audit me, et qui vígilat ad fores meas quotídie, et obsérvat ad postes óstii mei. ℣. Qui me invénerit, invéniet vitam, et háuriet salútem a Dómino."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Lk 1:46-47*\nAlleluia, alleluia. My soul doth magnify the Lord and my spirit hath rejoiced in God my Savior. Alleluia.",
                latin : "*Lk 1:46-47*\nAllelúja, allelúja. Magníficat ánima mea Dóminum: et exsultávit spíritus meus in Deo salutári meo. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 19:25-27*\nAt that time, there stood by the cross of Jesus His Mother, and His Mother’s sister, Mary of Cleophas, and Mary Magdalen. When Jesus therefore had seen His Mother and the disciple standing whom He loved, He saith to His Mother: Woman, behold thy son. After that, He saith to the disciple: Behold thy mother. And from that hour, the disciple took her to his own.",
                latin : "*Jn 19:25-27*\nIn illo tempore: Stabant autem juxta crucem Jesu, mater ejus, et soror matris ejus María Cléophæ, et María Magdaléne. Cum vidísset ergo Jesus matrem, et discípulum stantem, quem diligébat, dicit matri suæ: Múlier, ecce fílius tuus. Deínde dicit discípulo: Ecce mater tua. Et ex illa hora accépit eam discípulus in sua."
            ),
            PropersData (
                title : "Offertory",
                english : "*Lk 1:46*\nMy spirit hath rejoiced in God my Savior: because He that is mighty hath done great things to me and holy is His Name. (P. T. Alleluia.)",
                latin : "*Lk 1:46*\nExultavit spíritus meus in Deo salutári meo: quia fecit mihi magna qui potens est et sanctum nomen ejus. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Secret",
                english : "We who offer to Thy majesty the Lamb without blemish, beseech Thee, O Lord, that our hearts may be kindled by that divine fire which so ineffably inflamed the heart of the blessed Virgin Mary.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Majestati tuæ, Dómine, Agnum immaculátum offeréntes, quǽsumus: ut corda nostra ignis ille divínus accéndat, qui Cor beátæ Maríæ Vírginis ineffabíliter inflammávit.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Preface of the Blessed Virgin Mary",
                english : "It is truly meet and just, right and for our salvation that we always and everywhere give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should praise and bless, and proclaim Thee, in veneration of the Blessed Mary, ever Virgin: Who also conceived Thine only-begotten Son by the overshadowing of the Holy Spirit, and the glory of her virginity still abiding, gave forth to the world the everlasting Light, Jesus Christ our Lord. Through Whom the Angels praise Thy Majesty, the Dominations adore it, the Powers tremble: the heavens and the hosts of heaven, and the blessed Seraphim, together celebrate in exultation. With whom, we pray Thee, command that our voices of supplication also be joined in acknowledging Thee saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in Veneratióne beátæ Maríæ semper Vírginis collaudáre, benedícere et prædicáre. Quæ et Unigénitum tuum Sancti Spíritus obumbratióne concépit: et, virginitátis glória permanénte, lumen ætérnum mundo effúdit, Jesum Christum, Dóminum nostrum. Per quem maiestátem tuam laudant Ángeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Jn 19:27*\nJesus saith to His mother: Woman, behold thy son. After that, He saith to the disciple: Behold thy mother. And from that hour, the disciple took her to his own. (P. T. Alleluia.)",
                latin : "*Jn 19:27*\nDixit Jesus matri suæ: Múlier, ecce fílius tuus: deinde dixit discípulo: Ecce Mater tua. Et ex illa hora accépit eam discípulus in sua. (T.P. Allelúia.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "Refreshed by these divine gifts we humbly beseech Thee, O Lord, that by the intercession of the Blessed Virgin Mary whose immaculate heart we now solemnly celebrate, we may be delivered from present dangers and obtain the joys of eternal life.\nThrough our Lord...",
                latin : "Divinis refecti munéribus te, Dómine, supplíciter exorámus: ut beátæ Maríæ Vírginis intercessióne, cujus immaculáti Cordis solémnia venerándo égimus, a præséntibus perículis liberáti, ætérnæ vitæ gáudia consequámur.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "The Holy Trinity - Monday" : CelebrationData (
        rank : 4,
        title : "The Holy Trinity",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Tob 36:18*\nBlessed be the holy Trinity, and undivided unity: we will give glory to him, because he hath shown his mercy to us. (P. T. Aileluia, alleluia.)\n*Ps 8:2*\nO Lord, our Lord : how wonderful is thy name in the whole earth.\nGlory be to the Father...\nBlessed be the holy Trinity, and undivided unity: we will give glory to him, because he hath shown his mercy to us. (P.T. Alleluia, alleluia.)",
                latin : "*Tob 36:18*\nBenedicta sit sancta Trinitas, atque indivisa Unitas: confitebimur ei, quia fecit nobiscum misericordiam suam. (T.P. Allelúja, allelúja.)\n*Ps 8:2*\nDomine Dominus noster: quam admirabile est nomen tuum in universa terra.\nGlória Patri...\nBenedicta sit sancta Trinitas, atque indivisa Unitas: confitebimur ei, quia fecit nobiscum misericordiam suam. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O almighty and everlasting God, who hast granted thy servants, in the confession of the true faith, to acknowledge the glory of the eternal Trinity and, in the power of majesty, to adore the unity : we beseech thee that, by steadfastness in this faith we may be evermore defended from all adversity.\nThrough our Lord...",
                latin : "Omnipotens sempiterne Deus, qui dedisti famulis tuis in confessione veræ fidei æternæ Trinitatis gloriam agnoscere, et in potentia majestatis adorare Unitatem : quæsumus; ut ejusdem fidei firmitate, ab omnibus semper muniamur adversis.\nPer Dóminum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*2 Cor 13:11,13*\nBrethren: Rejoice, be perfect, take exhortation, be of one mind, have peace : and the God of peace and of love shall be with you. The grace of our Lord Jesus Christ, and the charity of God, and the communication of the Holy Ghost be with you all. Amen.",
                latin : "*2 Cor 13:11,13*\nFratres: Gaudete, perfecti estote, exhortamini, idem sapite, pacem habete, et Deus pacis et dilectionis erit vobiscum. Gratia Domini nostri Jesu Christi, et caritas Dei, et communicatio Sancti Spiritus sit cum omnibus vobis. Amen."
            ),
            PropersData (
                title : "Gradual",
                english : "*Dan 3:55-56*\nBlessed art thou, O Lord, who beholdest the depths, and sittest upon the Cherubim. Blessed art thou, O Lord, in the firmament of heaven, and worthy of praise for ever.",
                latin : "*Dan 3:55-56*\nBenedictus es, Domine, qui intueris abyssos, et sedes super Cherubim. Benedictus es, Domine, in firmamento cæli, et laudabilis in sæcula."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Dan 3:52*\nAlleluia, alleluia. Blessed art thou, O Lord, God of our fathers, and worthy of praise for ever. Alleluia.",
                latin : "*Dan 3:52*\nAllelúja, allelúja. Benedictus es, Domine Deus patrum nostrorum, et laudabilis in sæcula. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "We glorify, praise and bless, with our whole hearts, thee, O God the Father, not begotten : thee, the onlybegotten Son, thee, the Holy Ghost, the Paraclete, the holy and undivided Trinity. For thou art great, and dost wonderful things: thou alone art God. To thee be praise, to thee glory, to thee thanksgiving for ever and ever, O blessed Trinity.",
                latin : "Te Deum Patrem ingenitum, te Filium unigenitum, te Spiritum Sanctum Paraclitum, sanctam et individuam Trinitatem, toto corde confitemur, laudamus, atque benedicimus. Quoniam magnus es tu, et faciens mirabilia: tu es Deus solus. Tibi laus, tibi gloria, tibi gratiarum actio, in sæcula sempiterna, O beata Trinitas."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Dan 3:52*\nAlleluia, alleluia. Blessed art thou, O Lord, God of our fathers, and worthy of praise for ever. Alleluia.\nLet us bless the Father and the Son with the Holy Ghost. Alleluia.",
                latin : "*Dan 3:52*\nAllelúja, allelúja. Benedictus es, Domine Deus patrum nostrorum, et laudabilis in sæcula. Allelúja.\nBenedicamus Patrem et Filium cum Sancto Spiritu. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 15:26,27; 16:1-4*\nAt that time: Jesus said to his disciples: When the Paraclete cometh, whom I will send you from the Father, the Spirit of truth, who proceedeth from the Father, he shall give testimony of me; and you shall give testimony, because you are with me from the beginning. These things have I spoken to you, that you may not be scandalized. They will put you out of the synagogues; yea, the hour cometh, that whosoever killeth you will think that he doth a service to God. And these things will they do to you, because they have not known the Father, nor me. But these things I have told you, that, when the hour shall come, you may remember that I told you.",
                latin : "*Jn 15:26,27; 16:1-4*\nIn illo tempore: Dixit Jesus discipulis suis: Cum venerit Paraclitus, quem ego mittam vobis a Patre, Spiritum veritatis, qui a Patre procedit, ille testimonium perhibebit de me : et vos testimonium perhibebitis, quia ab initio mecum estis. Hæc locutus sum vobis, ut non scandalizemini. Absque synagogis facient vos : sed venit hora, ut omnis qui interficit vos, arbitretur obsequium se præstare Deo. Et hæc facient vobis, quia non noverunt Patrem, neque me: Sed hæc locutus sum vobis, ut, cum venerit hora eorum, reminiscamini, quia ego dixi vobis."
            ),
            PropersData (
                title : "Offertory",
                english : "*cf. Tob 12:6, cf. Dan 3:55*\nBlessed be God the Father, and the only-begotten Son of God, and also the Holy Spirit: because he hath shown his mercy towards us, (P. T. Alleluia.) Let us bless the Father and the Son with the Holy Ghost: let us praise him and exalt him above all for ever. Because he hath. Blessed art thou, that beholdest the depth, and sittest upon the Cherubim: and worthy to be praised and exalted above all for ever. Because he hath.",
                latin : "*cf. Tob 12:6, cf. Dan 3:55*\nBenedictus sit Deus Pater, unigenitusque Dei Filius, sanctus quoque Spiritus: quia fecit nobiscum misericordiam suam. (T.P. Alleluia.) Benedicamus Patrem et Filium cum Sancto Spiritu: laudemus et superexaltemus eum in sæcula. Quia fecit nobiscum misericordiam suam. Benedictus es, qui intueris abyssos et sedes super Cherubim: et superlaudabilis et superexaltatus in sæcula. Quia fecit nobiscum misericordiam suam."
            ),
            PropersData (
                title : "Secret",
                english : "Sanctify, we beseech thee, O Lord our God, by the invocation of thy holy name, the victim of this oblation : and through it make of us, too, an eternal offering to thee.\nThrough our Lord...",
                latin : "Sanctifica, quæsumus, Domine Deus noster, per tui sancti nominis invocationem hujus oblationis hostiam; et per eam nosmetipsos tibi perfice munus æternum.\nPer Dóminum..."
            ),
            PropersData (
                title : "Preface of the Holy Trinity",
                english : "It is truly meet and just, right and for our salvation, that we should at all times, and in all places, give thanks unto Thee, O holy Lord, Father almighty, everlasting God; Who, together with Thine only-begotten Son, and the Holy Ghost, art one God, one Lord: not in the oneness of a single Person, but in the Trinity of one substance. For what we believe by Thy revelation of Thy glory, the same do we believe of Thy Son, the same of the Holy Ghost, without difference or separation. So that in confessing the true and everlasting Godhead, distinction in persons, unity in essence, and equality in majesty may be adored. Which the Angels and Archangels, the Cherubim also and Seraphim do praise: who cease not daily to cry out, with one voice saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Qui cum unigénito Fílio tuo et Spíritu Sancto unus es Deus, unus es Dóminus: non in uníus singularitáte persónæ, sed in uníus Trinitáte substántiæ. Quod enim de tua glória, revelánte te, crédimus, hoc de Fílio tuo, hoc de Spíritu Sancto sine differéntia discretiónis sentímus. Ut in confessióne veræ sempiternǽque Deitátis, et in persónis propríetas, et in esséntia únitas, et in majestáte adorétur æquálitas. Quam laudant Angeli atque Archángeli, Chérubim quoque ac Séraphim: qui non cessant clamáre cotídie, una voce dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Tob 12:6*\nWe bless the God of heaven, and before all living we will praise him; because he hath shown his mercy to us. (P. T. Alleluia.)",
                latin : "*Tob 12:6*\nBenedicimus Deum cæli, et coram omnibus viventibus confitebimur ei : quia fecit nobiscum misericordiam suam. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "May the reception of this sacrament, O Lord our God, and the confession of the holy and eternal Trinity and its undivided unity, profit us to the salvation of body and soul.\nThrough our Lord...",
                latin : "Proficiat nobis ad salutem corporis et animæ, Domine Deus noster, hujus sacramenti susceptio : et sempiternæ sanctæ Trinitatis, ejusdemque individuæ unitatis confessio.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "The Holy Angels - Tuesday" : CelebrationData (
        rank : 4,
        title : "The Holy Angels",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 102:20*\nBless the Lord, all ye His Angels: you that are mighty in strength, and execute His word, hearkening to the voice of His orders. (P. T. Aileluia, alleluia.)\n*Ps ibid. 1*\nBless the Lord, O my soul: and let all that is within me bless His holy Name.\nGlory be to the Father...\nBless the Lord, all ye His Angels: you that are mighty in strength, and execute His word, hearkening to the voice of His orders. (P.T. Alleluia, alleluia.)",
                latin : "*Ps 102:20*\nBenedicite Dominum, omnes Angeli ejus: potentes virtute, qui facitis verbum ejus, ad audiendam vocem sermonum ejus. (T.P. Allelúja, allelúja.)\n*Ps ibid. 1*\nBenedic, anima mea, Domino: et omnia, quae intra me sunt, nomini sancto ejus.\nGlória Patri...\nBenedicite Dominum, omnes Angeli ejus: potentes virtute, qui facitis verbum ejus, ad audiendam vocem sermonum ejus. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, who hast constituted the services of Angels and of men in a wonderful order, mercifully grant, that they who ever stand before Thy face to do Thee service in heaven, may also defend our life upon earth.\nThrough our Lord...",
                latin : "Deus, qui, miro ordine, Angelorum ministerial hominumque dispensas: concede propitius; ut, a quibus tibi ministrantibus in cælo semper assistitur, ab his in terra vita nostra muniatur.\nPer Dóminum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Apoc 5:11-14*\nIn those days: I heard the voice of many Angels round about the throne, and the living creatures and the ancients; and the number of them was thousands of thou sands, saying with a loud voice: The Lamb that was slain is worthy to receive power, and divinity, and wisdom, and strength, and honor, and glory, and benediction. And every creature which is in heaven and on the earth, and under the earth, and such as are in the sea, and all that are in them, I heard all saying: To Him that sitteth on the throne, and to the Lamb, benediction, and honor, and glory, and power, for ever and ever. And the four living creatures said: Amen. And the four and twenty ancients fell down on their faces, and adored Him that liveth for ever and ever.",
                latin : "*Apoc 5:11-14*\nIn diebus illis: Audivi vocem Angelorum multorum in circuitu throni, et animalium, et seniorum, et erat numerus eorum milia milium, dicentium voce magna: Dignus est Agnus, qui occisus est, accipere virtutem, et divinitatem, et sapientiam, et fortitudinem, et honorem, et gloriam, et benedictionem. Et omnem creaturam, quae in coelo est, et super terram, et sub terra, et quae sunt in mari, et quae in eo: omnes audivi dicentes: Sedenti in throno, et Agno: benedictio, et honor, et gloria, et potestas in saecula saeculorum. Et quatuor animalia dicebant: Amen. Et viginti quatuor seniors ceciderunt in facies suas: et adoraverunt viventem in saecula saeculorum."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 148:1,2*\nPraise ye the Lord from the heavens: praise Him, in the high places. Praise ye Him, all His angels: praise ye Him, all His hosts.",
                latin : "*Ps 148:1,2*\nLaudate Dominum de coelis: laudate eum in excelsis. Laudate eum, omnes Angeli ejus: laudate eum, omnes virtutes ejus."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 137:1,2*\nAlleluia, alleluia. I will sing praise to Thee in the sight of the Angels: I will worship towards Thy holy temple, and I will give glory to Thy name. Alleluia.",
                latin : "*Ps 137:1,2*\nAllelúja, allelúja. In conspectu Angelorum psallam tibi: adorabo ad templum sanctum tuum, et confitebor nomini tuo. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 102:20-22*\nBless the Lord all ye His Angels: ye that are mighty in strength, and execute His word. Bless the Lord, all ye His hosts: ye ministers of His that do His will. Bless the Lord, all His works: in every place of His dominion, Oh my soul, bless thou the Lord.",
                latin : "*Ps 102:20-22*\nBenedicite Dominum, omnes Angeli ejus: potentes virtute, qui facitis verbum ejus. Benedicite Domino, omnes virtutes ejus: ministry ejus, qui facitis voluntatem ejus. Benedicite Domino, omnia opera ejus: in omni loco dominationis ejus, benedic, anima mea, Domino."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 137:1,2*\nAlleluia, alleluia. I will sing praise to Thee in the sight of the Angels: I will worship towards Thy holy temple, and I will give glory to Thy name. Alleluia.\n*Matt 28:2*\nAn Angel of the Lord descended from heaven: and coming rolled back the stone, and sat upon it. Alleluia.",
                latin : "*Ps 137:1,2*\nAllelúja, allelúja. In conspectu Angelorum psallam tibi: adorabo ad templum sanctum tuum, et confitebor nomini tuo. Allelúja.\n*Matt 28:2*\nAngelus Domini descendit de coelo, et accedens revolvit lapidem, et sedebat super eum. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 1:47,51*\nAt that time: Jesus saw Nathanael coming to Him: and He saith of him: Behold an Israelite indeed, in whom there is no guile. Nathanael saith to Him: Whence knowest Thou me? Jesus answered, and said to him: Before that Philip called thee, when thou wast under the fig-tree, I saw thee. Nathanael answered Him, and said: Rabbi, Thou art the Son of God, Thou art the King of Israel. Jesus answered, and said to him: Because I said unto thee, I saw thee under the fig-tree, thou believest: greater things than these shalt thou see. And He said to him: Amen, amen I say to you, you shall see the heavens opened, and the Angels of God ascending and descending upon the Son of Man.",
                latin : "*Jn 1:47,51*\nIn illo tempore: Vidit Jesus Nathanaël venientem ad se, et dicit de eo: Ecce vere Israëlita, in quo dolus non est. Dicit ei Nathanaël: Unde me nosti? Respondit Jesus, et dixit ei: Priusquam te Philippus vocaret, cum esses sub ficu, vidi te. Respondit ei Nathanaël, et ait: Rabbi, tu es Filius Dei, tu es Rex Israël. Respondit Jesus, et dixit ei: Quia dixi tibi: Vidi te sub ficu, credis: majus his videbis. Et dicit ei: Amen, amen dico vobis, videbitis coelum apertum, et Angelos Dei ascendentes, et descendentes supra Filium hominis."
            ),
            PropersData (
                title : "Offertory",
                english : "*Apoc 8:3-4*\nAn angel stood near the altar of the temple, having a golden censer in his hand: and there was given to him much incense, and the smoke of the perfumes ascended before God. (P. T. Alleluia.)",
                latin : "*Apoc 8:3-4*\nStetit Angelus juxta aram templi, habens thuribulum aureum in manu sua: et data sunt ei incensa multa: et ascendit fumus aromatum in conspectu Dei. (T.P. Alleluia.)"
            ),
            PropersData (
                title : "Secret",
                english : "We offer unto Thee, O Lord, the Sacrifice of praise and humbly beseech Thee, that through the prayers of the Angels who plead for us, Thou wouldst graciously accept it and make it of avail to us for salvation.\nThrough our Lord...",
                latin : "Hostias tibi, Domine, laudis offerimus, suppliciter deprecantes: ut easdem, angelico pro nobis interveniente suffragio, et placatus accipias, et ad salute nostram provenire concedas.\nPer Dóminum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "Angels, Archangels, Thrones and Dominions, Principalities, and Powers, the Virtues of the heavens, Cherubim and Seraphim, bless ye the Lord for ever. (P. T. Alleluia.)",
                latin : "Angeli, Archangeli, Throni et Dominationes, Principatus et Potestates, Virtutes cœlorum, Cherubim atque Seraphim, Dominum benedicite in aeternum. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "We who are filled with the heavenly blessing, humbly beseech Thee, O Lord, that the Mysteries which we celebrate with this imperfect worship of ours may be profitable to us by the help of Thy holy Angels and Archangels.\nThrough our Lord...",
                latin : "Repleti, Domine, benedictione coelesti, suppliciter imploramus: ut, quod fragili celebramus officio, sanctorum Angelorum atque Archangelorum nobis prodesse sentiamus auxilio.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "St Joseph - Wednesday" : CelebrationData (
        rank : 4,
        title : "St Joseph",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 32:20,21; 79:2*\nThe Lord is our helper and protector: in Him our heart shall rejoice, and in His holy name we have trusted. (P. T. Aileluia, alleluia.)\n*Ps.*\nGive ear, O Thou that rulest Israel: Thou that leadest Joseph like a sheep.\nGlory be to the Father...\nThe Lord is our helper and protector: in Him our heart shall rejoice, and in His holy name we have trusted. (P.T. Alleluia, alleluia.)",
                latin : "*Ps 32:20,21; 79:2*\nAdjutor et protector noster est Dóminus: in eo lætábitur cor nostrum, et in nómine sancto ejus sperávimus. (T.P. Allelúja, allelúja.)\n*Ps.*\nQui regis Israel, inténde: qui dedúcis, velut ovem, Joseph.\nGlória Patri...\nAdjutor et protector noster est Dóminus: in eo lætábitur cor nostrum, et in nómine sancto ejus sperávimus. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, Who in Thine unspeakable providence didst vouchsafe to choose blessed Joseph for Thy most holy Mother's spouse; grant, we beseech Thee, that we who revere him as our protector upon earth, may become worthy to have him for our intercessor in heaven.\nWho livest and reignest...",
                latin : "Deus, qui ineffábili providéntia beátum Joseph sanctíssimæ Genetrícis tux sponsum elígere dignátus es: præsta, quæsumus; ut, quem protectórem venerámur in terris, intercessórem habére mereámur in cælis:\nQui vivis et regnas..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Gen 49:22-26*\nJoseph was a growing son, a growing son, and comely to behold: the daughters run to and fro upon the wall. But they that held darts provoked him, and quarrelled with him, and envied him. His bow rested upon the strong, and the bands of his arms and his hands were loosed, by the hands of the mighty one of Jacob: thence he came forth a pastor, the stone of Israel. The God of thy father shall be thy helper, and the Almighty shall bless thee with the blessings of heaven above, with the blessings of the deep that lieth beneath, with the blessings of the breasts and of the womb. The blessings of thy father are strengthened with the blessings of his fathers: until the desire of the everlasting hills shall come; may they be upon the head of Joseph, and upon the crown of the Nazarite among his brethren.",
                latin : "*Gen 49:22-26*\nFilius accréscens Joseph, filius accréscens, et decórus aspéctu: fíliæ discurrérunt super murum. Sed exasperavérunt eum, et jurgáti sunt, inviderúntque illi habéntes jácula. Sedit in forti arcus ejus, et dissolúta sunt vincula bracchiórum et mánuum illíus per manus poténtis Jacob: inde pastor egréssus est, lapis Israel. Deus patris tui erit adjútor tuus, et Omnípotens benedícet tibi benedictiónibus cæli désuper, benedictiónibus abyssi jacéntis deórsum, benedictiónibus úberum et vulvæ. Benedictiónes patris tui confortátæ sunt benedictiónibus patrum ejus, donec veníret Desidérium cóllium æternórum: fiant in capite Joseph, et in vértice Nazaræi inter fratres suos."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 20:4,5*\nThou hast prevented him with blessings of sweetness: Thou hast set on his head a crown of precious stones. He asked life of Thee, and Thou hast given him length of days for ever and ever.",
                latin : "*Ps 20:4,5*\nDomine, prævenisti eum in benedictionibus dulcedinis: posuisti in capite ejus coronam de lapide pretioso. Vitam petiit a te, et tribuisti et longitudinem dierum in sæculum sæculi."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 137:1,2*\nAlleluia, alleluia. Obtain for us, Joseph, grace to lead an innocent life; and may our life ever be shielded by thy patronage. Alleluia.",
                latin : "*Ps 137:1,2*\nAllelúja, allelúja. Fac nos innócuam, Joseph, decúrrere vitam: sitque tuo semper tuta patrocínio. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 111:1-3*\nBlessed is the man that feareth the Lord: he shall delight exceedingly in His commandments. His seed shall be mighty upon earth: the generation of the righteous shall be blessed. Glory and wealth shall be in his house: and his justice remaineth for ever and ever.",
                latin : "*Ps 111:1-3*\nBeatus vir, qui timet Dóminum: in mandátis ejus cupit nimis. Potens in terra erit semen ejus: generátio rectórum benedicétur. Glória et divítiæ in domo ejus: et justítia ejus manet in sæculum sæculi."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 137:1,2*\nAlleluia, alleluia. In whatever tribulation they shall cry to Me, I will hear them, and be their protector always. Alleluia.\n*Matt 28:2*\nObtain for us, Joseph, grace to lead an innocent life; and may our life ever be shielded by thy patronage. Alleluia.",
                latin : "*Ps 137:1,2*\nAllelúja, allelúja. De quacúmque tribulatióne clamáverint ad me, exáudiam eos, et ero protéctor eórum semper. Allelúja.\n*Matt 28:2*\nFac nos innócuam, Joseph, decúrrere vitam: sitque tuo semper tuta patrocínio. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 3:21-23*\nAt that time: It came to pass, when all the people were baptized, that Jesus also being baptized and praying, heaven was opened: and the Holy Ghost descended in a bodily shape as a dove upon Him: and a voice came from heaven: Thou art My beloved Son, in Thee I am well pleased. And Jesus Himself was beginning about the age of thirty years: being (as it was supposed) the son of Joseph.",
                latin : "*Lk 3:21-23*\nIn illo témpore: Factum est autem, cum baptizarétur omnis pópulus, et Jesu baptizáto et oránte, apértum est cælum: et descéndit Spiritus Sanctus corporáli spécie sirut colúmba in ipsum: et vox de cælo facta est: Tu es Filius meus diléctus, in te complácui mihi. Et ipse Jesus erat incípiens quasi annórum trigínta, ut putabátur, filius Joseph."
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 147:12,13*\nPraise the Lord, O Jerusalem, because He hath strengthened the bolts of thy, gates: He hath blessed thy children within thee. (P. T. Alleluia.)",
                latin : "*Ps 147:12,13*\nLauda, Jerusalem, Dóminum: quóniam confortávit seras portárum tuárum, benedíxit fíliis tuis in te. (T.P. Alleluia.)"
            ),
            PropersData (
                title : "Secret",
                english : "Supported by the patronage of the spouse of Thy most holy Mother, we beseech Thy clemency, O Lord: that Thou wouldst make our hearts despise all earthly things, and love Thee, the true God, with perfect charity.\nWho livest and reignest...",
                latin : "Sanctissimæ Genetrícis tua sponsi patrocínio suffúlti, rogámus, Dómine, cleméntiam tuam: ut corda nostra fácias terréna cuncta despícere, ac te verum Deum perfécta caritáte dilígere:\nQui vivis et regnas..."
            ),
            PropersData (
                title : "Preface of St Joseph",
                english : "It is truly meet and just, right and for our salvation, that we should at all times and in all places, give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should magnify with due praises, bless and proclaim Thee on the solemnity of blessed Joseph; who, being a just man, was given by Thee as a Spouse to the Virgin Mother of God, and, as a faithful and prudent servant was set over Thy Family, that, with fatherly care, he might guard Thine only-begotten Son, conceived by the overshadowing of the Holy Ghost, even Jesus Christ, our Lord. Through whom the Angels praise Thy Majesty, the Dominations worship it, and the Powers stand in awe. The heavens and the heavenly hosts together with the blessed Seraphim in triumphant chorus unite to celebrate it. Together with them we entreat Thee that Thou mayest bid our voices also to be admitted, while we say with lowly praise:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in *Veneratióne* beáti Joseph débitis magnificáre præcóniis, benedícere et prædicáre. Qui et vir justus, a te Deíparæ Vírgini Sponsus est datus: et fidélis servus ac prudens, super Famíliam tuam est constitútus: ut Unigénitum tuum, Sancti Spíritus obumbratióne concéptum, paterna vice custodíret, Jesum Christum, Dóminum nostrum. Per quem majestátem tuam laudant Angeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Matt 1:16*\nBut Jacob begot Joseph, the husband of Mary, of whom was born Jesus, who is called Christ. (P. T. Alleluia.)",
                latin : "*Tob 12:6*\nJacob autem génuit Joseph, virum Maria, de qua natos est Jesus, qui vocátur Christus. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "We who have been refreshed at the fountain of divine blessing, beseech Thee, O Lord our God: that as Thou dost gladden us by the protection of blessed Joseph, so by his merits and intercession Thou wouldst make us partakers of everlasting glory.\nThrough our Lord...",
                latin : "Divini múneris fonte refécti, quæsumus, Dómine, Deus noster: ut, sicut nos facis beáti Joseph protectióne gaudere; ita, ejus méritis et intercessióne, cæléstis gloria fácias esse partícipes.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "Ss Peter & Paul - Wednesday" : CelebrationData (
        rank : 4,
        title : "Ss Peter & Paul",
        colors : "r",
        propers : [
            PropersData (
                title : "Introit (Outside Paschaltide)",
                english : "*Ps 138:17*\nThy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened.\n*Ps 138:1,2*\nLord, Thou hast proved me, and known me: Thou hast known my sitting down, and my rising up.\nGlory be to the Father...\nThy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened.",
                latin : "*Ps 138:17*\nMihi autem nimis honoráti sunt amíci tui, Deus: nimis confortátus est principátus eórum.\n*Ps 138:1,2*\nDómine, probásti me, et cognovísti me: tu cognovísti sessiónem meam, et resurrectiónem meam.\nGlória Patri...\nMihi autem nimis honoráti sunt amíci tui, Deus: nimis confortátus est principátus eórum."
            ),
            PropersData (
                title : "Introit (Paschaltide)",
                english : "*Ps 63:3*\nThou last protected me, O God, from the assembly of the malignant, alleluia: from the multitude of the workers of iniquity, Alleluia. Alleluia.\n*Ps 63:2*\nHear, O God, my prayers, when I make supplication to Thee: deliver my soul from the fear of the enemy.\nGlory be to the Father...\nThou last protected me, O God, from the assembly of the malignant, Alleluia: from the multitude of the workers of iniquity, Alleluia. Alleluia.",
                latin : "*Ps 63:3*\nProtexisti me, Deus, a convéntu malignántium, allelúia: a multitúdine operántium iniquitátem, allelúia, allelúia.\n*Ps 63:2*\nExáudi, Deus, oratiónem meam cum déprecor: a timóre inimíci éripe ánimam meam.\nGlória Patri...\nProtexisti me, Deus, a convéntu malignántium, allelúia: a multitúdine operántium iniquitátem, allelúia, allelúia."
            ),
            PropersData (
                title : "Collect",
                english : "O God, Whose right hand upheld blessed Peter walking upon the waves, lest he should sink, and delivered his fellow apostle Paul when shipwrecked for the third time from the depth of the sea; hear us in Thy mercy, and grant that through their merits we may obtain the glory of everlasting life.\nThou who are God...",
                latin : "Deus, cujus déxtera beátum Petrum ambulántem in flúctibus, ne mergerétur, eréxit, et coapóstolum ejus Paulum tértio naufragántem, de profúndo pélagi liberávit: exáudi nos propítius, et concede; ut, ambórum méritis, aternitátis glóriam consequámur:\nQui vivis et regnas..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Acts 5:12-16*\nIn those days, by the hands of the apostles were many sings and wonders wrought among the people; and they were all with one accord in Solomon's porch. But of the rest no man durst join himself to them; but the people magnified them. And the multitude of men and women that believed in the Lord was more increased; insomuch, that they brought forth the sick into the streets, and laid them on beds and couches; that when Peter came, his shadow, at least, might overshadow any of them, and they might be delivered from their infirmities. And there came also together to Jerusalem a multitude out of the neighbouring cities, bringing sick persons, and such as were troubled with unclean spirits, who were all healed.",
                latin : "*Acts 5:12-16*\nIn diébus illis: Per manus Apostolórum fiébant signa, et prodígia multa in plebe. Et crant unanímiter omnes in pórticu Salomónis. Ceterórum autem nemo audébat se conjúngere illis: sed magnificábat eos pópulus. Magis autem augebátur credéntium in Dómino multitúdo virórum ac mulierum, ita ut in platéas ejícerent infírmos, et ponerent in léctulis ac grabátis, ut, veniénte Petro, saltem umbra illius obumbráret quemquam illórum, et liberarentur ab infirmitátibus suis. Concurrébat autem et multitúdo vicinárum civitátum Jerusalem, afferéntes agros, et vexátos a spirítibus immúndis: qui curabántur omnes."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 44:17,18*\nThou shalt make them princes over all the earth: they shall be mindful of Thy name, O Lord. Instead of Thy fathers sons are born to Thee: therefore shall people praise Thee.",
                latin : "*Ps 44:17,18*\nConstítues eos príncipes super omnem terram: mémores erunt nóminis tui, Dómine. Pro pátribus tuis nati sunt tibi fílii: proptérea pópuli confitebúntur tibi."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. Thy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened. Alleluia.",
                latin : "Allelúja, allelúja. Nimis honoráti sunt amíci tui, Deus: nimis confortátus est principátus eórum. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 125:5,6*\nThey that sow in tears shall reap in joy. Going, they went and wept, casting their seeds. They that sow in tears shall reap in joy. Going, they went and wept, casting their seeds. But coming, they shall come with joyfulness, carrying their sheaves.",
                latin : "*Ps 125:5,6*\nQui seminant in lácrimis, in gáudio metent. Eúntes ibant et flebant, mitténtes sémina sua. Veniéntes autem vénient cum exsultatióne, portántes manípulos suos."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 88:6*\nAlleluia, alleluia. The Heavens shall confess Thy wonders, O Lord; and Thy truth in the Church of the saints. Alleluia.\n*Ps 20:4*\nI have chosen you from the world, that thou should go, and should bring forth fruit, and your fruit should remain. Alleluia.",
                latin : "*Ps 88:6*\nAllelúja, allelúja. Confitebúntur cœli mirabília tua, Dómine: étenim veritátem tuam in ecclésia sanctórum. Allelúja.\n*Ps 20:4*\nEgo vos elegi di mundo, ut eatis, et fructum afferatis, et frucus vester maneat. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Matt 19:27-29*\nAt that time, Peter said to Jesus: Behold we have left all things, and have followed thee: what therefore shall we have? And Jesus said to them: Amen, I say to you, that you, who have followed me, in the regeneration when the Son of man shall sit on the seat of his majesty, you also shall sit on twelve seats, judging the twelve tribes of Israel. And every one that hath left house, or brethren, or sisters, or father, or mother, or wife, or children, or lands, for My Name's sake, shall receive an hundredfold, and shall possess life everlasting.",
                latin : "*Matt 19:27-29*\nIn illo tempore: Dixit Petrus ad Jesum: Ecce nos reliquimus omnia, et secuti sumus te: quid ergo erit nobis? Jesus autem dixit illis: Amen dico vobis, quod vos, qui secuti estis me, in regeneratione cum sederit Filius hominis in sede maiestatis suae, sedebitis et vos super sedes duodecim, iudicantes duodecim tribus Israel. Et omnis qui reliquerit domum, vel fratres, aut sorores, aut patrem, aut matrem, aut uxorem, aut filios, aut agros propter nomen meum, centuplum accipiet, et vitam aeternam possidebit."
            ),
            PropersData (
                title : "Offertory (Outside Paschaltide)",
                english : "*Ps 18:5*\nTheir sound went forth into all the earth; and their words to the ends of the world.",
                latin : "*Ps 18:5*\nIn omnem terram exivit sonus eorum: et in fines orbis terræ vera eorum."
            ),
            PropersData (
                title : "Offertory (Paschaltide)",
                english : "*Ps 88:6*\nThe Heavens shall confess Thy wonders, O Lord, and Thy truth in the Church of the Saints, alleluia, alleluia.",
                latin : "*Ps 88:6*\nConfitebúntur cœli mirabília tua, Dómine, et veritátem tuam in ecclésia sanctórum, alleluia, alleluia."
            ),
            PropersData (
                title : "Secret",
                english : "We offer up to Thee, O Lord, our prayers and our gifts, that by the pleading of Thy holy apostles Peter and Paul, they may become worthy of Thy regard.\nThrough our Lord...",
                latin : "Offérimus tibi, Dómine, preces et múnera: gum ut tuo Sint digna conspéctu, Apostolórum tuórum Petri et Pauli précibus adjuvémur.\nPer Dóminum..."
            ),
            PropersData (
                title : "Preface of the Apostles",
                english : "It is truly meet and just, right and for our salvation, to entreat Thee humbly, O Lord, that Thou wouldst not desert Thy flock, O everlasting Shepherd, but, through Thy blessed Apostles, wouldst keep it under Thy constant protection; that it may be governed by those same rulers, whom as vicars of Thy work, Thou didst set over it to be its pastors. And therefore with Angels and Archangels, with Thrones and Dominations, and with all the hosts of the heavenly army, we sing the hymn of Thy glory, evermore saying:\n\n*Preface of Easter during Paschaltide*",
                latin : "Vere dignum et justum est, æquum et salutáre: Te, Dómine, supplíciter exoráre, ut gregem tuum, Pastor ætérne, non déseras: sed per beátos Apóstolos tuos contínua protectióne custódias. Ut iísdem rectóribus gubernétur, quos óperis tui vicários eídem contulísti præésse pastóres. Et ídeo cum Angelis et Archángelis, cum Thronis et Dominatiónibus cumque omni milítia cœléstis exércitus hymnum glóriæ tuæ cánimus, sine fine dicéntes:\n\n*Preface of Easter during Paschaltide*"
            ),
            PropersData (
                title : "Communion (Outside Paschaltide)",
                english : "*Matt 19:28*\nYou who have followed Me shall sit on seats judging the twelve tribes of Israel.",
                latin : "*Matt 19:28*\nVos, qui secuti estis me, sedebitis super sedes, judicantes duodecim tribus Israel."
            ),
            PropersData (
                title : "Communion (Paschaltide)",
                english : "*Ps 63:11*\nThe just shall rejoice in the Lord, and shall hope in Him: and all the upright in heart shall be praised, Alleluia, alleluia.",
                latin : "*Ps 63:11*\nLætábitur justus in Dómino, et sperábit in eo: et laudabúntur omnes recti corde, Alleluia, alleluia."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Protect Thy people, O Lord, and evermore help those who put their trust in the patronage of Thy holy apostles Peter and Paul.\nThrough our Lord...",
                latin : "Protege, Dómine, pópulum tuum: et Apostolórum tuórum Petri et Pauli patrocínio confidéntem, perpétua defensióne consérva.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "All Holy Apostles - Wednesday" : CelebrationData (
        rank : 4,
        title : "The Holy Apostles",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit (Outside Paschaltide)",
                english : "*Ps 138:17*\nThy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened.\n*Ps 138:1,2*\nLord, Thou hast proved me, and known me: Thou hast known my sitting down, and my rising up.\nGlory be to the Father...\nThy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened.",
                latin : "*Ps 138:17*\nMihi autem nimis honoráti sunt amíci tui, Deus: nimis confortátus est principátus eórum.\n*Ps 138:1,2*\nDómine, probásti me, et cognovísti me: tu cognovísti sessiónem meam, et resurrectiónem meam.\nGlória Patri...\nMihi autem nimis honoráti sunt amíci tui, Deus: nimis confortátus est principátus eórum."
            ),
            PropersData (
                title : "Introit (Paschaltide)",
                english : "*Ps 63:3*\nThou last protected me, O God, from the assembly of the malignant, alleluia: from the multitude of the workers of iniquity, Alleluia. Alleluia.\n*Ps 63:2*\nHear, O God, my prayers, when I make supplication to Thee: deliver my soul from the fear of the enemy.\nGlory be to the Father...\nThou last protected me, O God, from the assembly of the malignant, Alleluia: from the multitude of the workers of iniquity, Alleluia. Alleluia.",
                latin : "*Ps 63:3*\nProtexisti me, Deus, a convéntu malignántium, allelúia: a multitúdine operántium iniquitátem, allelúia, allelúia.\n*Ps 63:2*\nExáudi, Deus, oratiónem meam cum déprecor: a timóre inimíci éripe ánimam meam.\nGlória Patri...\nProtexisti me, Deus, a convéntu malignántium, allelúia: a multitúdine operántium iniquitátem, allelúia, allelúia."
            ),
            PropersData (
                title : "Collect",
                english : "God, Who hast granted us to come to the knowledge of Thy name through Thy blessed Apostles, grant us to celebrate their everlasting glory by advancing in knowledge and to improve by this celebration.\nThrough our Lord...",
                latin : "Deus, qui nos per beátos Apóstolos tuos, ad agnitiónem tui nóminis veníre tribuísti: da nobis eórum glóriam sempitérnam et proficiéndo celebráre, et celebrándo profícere.\nPer Dóminum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Eph 4:7-13*\nTo each one of us grace was given according to the measure of Christ’s bestowal. Thus it says: Ascending on high, He led away captives; He gave gifts to men. Now this: He ascended, what does it mean but that He also first descended into the lower parts of the earth? He Who descended, He it is Who ascended also above all the heavens, that He might fill all things. And He Himself gave some men as apostles, and some as prophets, others again as evangelists, and others as pastors and teachers, in order to perfect the saints for a work of ministry, for building up the body of Christ, until we all attain to the unity of the faith and of the deep knowledge of the Son of God, to perfect manhood, to the mature measure of the fullness of Christ.",
                latin : "*Eph 4:7-13*\nFratres: Unicuíque nostrum data est grátia secúndum mensúram donatiónis Christi. Propter quod dicit: Ascéndens in altum, captívam duxit captivitátem: dedit dona homínibus. Quod autem ascéndit, quid est, nisi quia et descéndit primum in inferióres partes terræ? Qui descéndit, ipse est et qui ascéndit super omnes coelos, ut impléret ómnia. Et ipse dedit quosdam quidem apóstolos, quosdam autem prophétas, álios vero evangelístas, álios autem pastóres et doctóres, ad consummatiónem sanctórum in opus ministérii, in ædificatiónem córporis Christi: donec occurrámus omnes in unitátem fídei, et agnitiónis Fílii Dei, in virum perféctum, in mensúram ætátis plenitúdinis Christi."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 44:17,18*\nThou shalt make them princes over all the earth: they shall be mindful of Thy name, O Lord. Instead of Thy fathers sons are born to Thee: therefore shall people praise Thee.",
                latin : "*Ps 44:17,18*\nConstítues eos príncipes super omnem terram: mémores erunt nóminis tui, Dómine. Pro pátribus tuis nati sunt tibi fílii: proptérea pópuli confitebúntur tibi."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. Thy friends, O God, are made exceedingly honourable: their principality is exceedingly strengthened. Alleluia.",
                latin : "Allelúja, allelúja. Nimis honoráti sunt amíci tui, Deus: nimis confortátus est principátus eórum. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 125:5,6*\nThey that sow in tears shall reap in joy. Going, they went and wept, casting their seeds. They that sow in tears shall reap in joy. Going, they went and wept, casting their seeds. But coming, they shall come with joyfulness, carrying their sheaves.",
                latin : "*Ps 125:5,6*\nQui seminant in lácrimis, in gáudio metent. Eúntes ibant et flebant, mitténtes sémina sua. Veniéntes autem vénient cum exsultatióne, portántes manípulos suos."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 88:6*\nAlleluia, alleluia. The Heavens shall confess Thy wonders, O Lord; and Thy truth in the Church of the saints. Alleluia.\n*Ps 20:4*\nI have chosen you from the world, that thou should go, and should bring forth fruit, and your fruit should remain. Alleluia.",
                latin : "*Ps 88:6*\nAllelúja, allelúja. Confitebúntur cœli mirabília tua, Dómine: étenim veritátem tuam in ecclésia sanctórum. Allelúja.\n*Ps 20:4*\nEgo vos elegi di mundo, ut eatis, et fructum afferatis, et frucus vester maneat. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Matt 19:27-29*\nAt that time, Peter said to Jesus: Behold we have left all things, and have followed thee: what therefore shall we have? And Jesus said to them: Amen, I say to you, that you, who have followed me, in the regeneration when the Son of man shall sit on the seat of his majesty, you also shall sit on twelve seats, judging the twelve tribes of Israel. And every one that hath left house, or brethren, or sisters, or father, or mother, or wife, or children, or lands, for My Name's sake, shall receive an hundredfold, and shall possess life everlasting.",
                latin : "*Matt 19:27-29*\nIn illo tempore: Dixit Petrus ad Jesum: Ecce nos reliquimus omnia, et secuti sumus te: quid ergo erit nobis? Jesus autem dixit illis: Amen dico vobis, quod vos, qui secuti estis me, in regeneratione cum sederit Filius hominis in sede maiestatis suae, sedebitis et vos super sedes duodecim, iudicantes duodecim tribus Israel. Et omnis qui reliquerit domum, vel fratres, aut sorores, aut patrem, aut matrem, aut uxorem, aut filios, aut agros propter nomen meum, centuplum accipiet, et vitam aeternam possidebit."
            ),
            PropersData (
                title : "Offertory (Outside Paschaltide)",
                english : "*Ps 18:5*\nTheir sound went forth into all the earth; and their words to the ends of the world.",
                latin : "*Ps 18:5*\nIn omnem terram exivit sonus eorum: et in fines orbis terræ vera eorum."
            ),
            PropersData (
                title : "Offertory (Paschaltide)",
                english : "*Ps 44:17,18*\nThou shalt make them princes over all the earth: they shall remember Thy name, O Lord, in every progeny and generation. Alleluia, alleluia.",
                latin : "*Ps 44:17,18*\nConstitues eos principes super omnem terram: memores erunt nominis tui, Dominie, in omni progenie et generatione. Alleluia, alleluia."
            ),
            PropersData (
                title : "Secret",
                english : "Venerating the everlasting glory of Thy holy Apostles, we beseech Thee, O Lord, that, being purified by these sacred mysteries, it may the more worthily be celebrated by us.\nThrough our Lord...",
                latin : "Glóriam, Dómine, sanctórum Apostolórum tuórum perpétuam venerántes: quæsumus; ut eam, sacris mystériis expiáti, dignius celebrémus.\nPer Dóminum..."
            ),
            PropersData (
                title : "Preface of the Apostles",
                english : "It is truly meet and just, right and for our salvation, to entreat Thee humbly, O Lord, that Thou wouldst not desert Thy flock, O everlasting Shepherd, but, through Thy blessed Apostles, wouldst keep it under Thy constant protection; that it may be governed by those same rulers, whom as vicars of Thy work, Thou didst set over it to be its pastors. And therefore with Angels and Archangels, with Thrones and Dominations, and with all the hosts of the heavenly army, we sing the hymn of Thy glory, evermore saying:\n\n*Preface of Easter during Paschaltide*",
                latin : "Vere dignum et justum est, æquum et salutáre: Te, Dómine, supplíciter exoráre, ut gregem tuum, Pastor ætérne, non déseras: sed per beátos Apóstolos tuos contínua protectióne custódias. Ut iísdem rectóribus gubernétur, quos óperis tui vicários eídem contulísti præésse pastóres. Et ídeo cum Angelis et Archángelis, cum Thronis et Dominatiónibus cumque omni milítia cœléstis exércitus hymnum glóriæ tuæ cánimus, sine fine dicéntes:\n\n*Preface of Easter during Paschaltide*"
            ),
            PropersData (
                title : "Communion (Outside Paschaltide)",
                english : "*Matt 19:28*\nYou who have followed Me shall sit on seats judging the twelve tribes of Israel.",
                latin : "*Matt 19:28*\nVos, qui secuti estis me, sedebitis super sedes, judicantes duodecim tribus Israel."
            ),
            PropersData (
                title : "Communion (Paschaltide)",
                english : "*Ps 18:5*\nTheir sound went forth into all the earth; and their words to the ends of the world. Alleluia, alleluia.",
                latin : "*Ps 18:5*\nIn omnem terram exivit sonus eorum: et in fines orbis terræ vera eorum. Alleluia, alleluia."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Having received Thy sacraments, we beseech and supplicate Thee, O Lord, that, by the intercession of Thy blessed Apostles, the things which we do for the veneration of their glory may profit us unto our healing.\nThrough our Lord...",
                latin : "Percéptis, Dómine, sacraméntis, supplíciter exorámus; ut, intercedéntibus beátis Apóstolis tuis, quæ pro illórum veneránda gérimus passióne, nobis profíciant ad medélam.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "The Holy Ghost - Thursday" : CelebrationData (
        rank : 4,
        title : "The Holy Ghost",
        colors : "r",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Wis 1:7*\nThe Spirit of the Lord hath filled the whole world, alleluia; and that which containeth all things hath knowledge of the voice. (P. T. Aileluia, alleluia.)\n*Ps 67:2*\nLet God arise, and let His enemies be scattered: and let them that hate Him flee from before His face.\nGlory be to the Father...\nThe Spirit of the Lord hath filled the whole world, alleluia; and that which containeth all things hath knowledge of the voice. (P.T. Alleluia, alleluia.)",
                latin : "*Wis 1:7*\nSpiritus Dómini replévit orbem terrárum, allelúia: et hoc quod cóntinet ómnia, sciéntiam habet vocis. (T.P. Allelúja, allelúja.)\n*Ps 67:2*\nExsúrgat Deus, et dissipéntur in imíci ejus: et fúgiant, qui odérunt eum, a fácie ejus.\nGlória Patri...\nSpiritus Dómini replévit orbem terrárum, allelúia: et hoc quod cóntinet ómnia, sciéntiam habet vocis. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, Thou didst teach the hearts of Thy faithful by the light of Thy Holy Spirit; grant that by the same Spirit we may be truly wise, and ever rejoice in His consolation.\nThrough our Lord...",
                latin : "Deus, qui corda fidélium Sancti Spiritus illustratióne docuísti: da nobis in eódem Spiritu recta sápere; et de ejus semper consolatióne gaudére.\nPer Dóminum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Acts 8:14-17*\nIn those days, when the apostles that were in Jerusalem had heard that Samaria had received the word of God, they sent unto them Peter and John; who, when they were come, prayed for them, that they might receive the Holy Ghost: for He was not as yet come upon any of them; but they were only baptized in the name of the Lord Jesus. Then they laid their hands upon them, and they received the Holy Ghost.",
                latin : "*Acts 8:14-17*\nIn diébus illis: Cum audíssent Apóstoli, qui erant Jerosólymis, quod recepíssent Samaria verbum Dei, misérunt ad eos Petrum, et Joánnem. Qui cum veníssent, oravérunt pro ipsis ut accíperent Spíritum Sanctum: nondum enim in quemquam illórum vénerat, sed baptizáti tantum erant in nómine Dómini Jesu. Tunc imponébant manus super illos, et accipiébant Spíritum Sanctum."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 32:12,6*\nBlessed is the nation whose God is the Lord: the people whom He hath chosen for His inheritance. By the word of the Lord the heavens were established; and all the power of them by the spirit of His mouth.",
                latin : "*Ps 32:12,6*\nBeáta gens, cajus est Dóminus Deus eórum: pópulus, quem elégit Dóminus in hereditátem sibi. Verbo Dómini cæli firmáti sunt: et Spiritu oris ejus omnis virtus eórum."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. Come, O Holy Spirit, fill the hearts of Thy faithful, and kindle in them the fire of Thy love. Alleluia.",
                latin : "Allelúja, allelúja. Veni, Sancte Spiritus, reple tuórum corda fidélium: et tui amóris in eis ignem accénde. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 103:30*\nSend forth Thy Spirit, and they shall be created; and Thou shalt renew the face of the earth. V. O Lord, how good and sweet is Thy Spirit within us!\n*(Here Kneel)*\nCome, O Holy Spirit, fill the hearts of Thy faithful, and kindle in them the fire of Thy love.",
                latin : "*Ps 103:30*\nEmítte Spiritum tuum, et creabúntur: et renovábis fáciem terræ. V. O quam bonus et suávis est, Dómine, Spiritus tuus in nobis!\n*(Here Kneel)*\nVeni, Sancte Spiritus, reple tuórum corda fidélium: et tui amóris in eis ignem accénde."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 103:30*\nAlleluia, alleluia. Send forth Thy Spirit, and they shall be created; and Thou shalt renew the face of the earth. Alleluia.\nCome, O Holy Spirit, fill the hearts of Thy faithful, and kindle in them the fire of Thy love. Alleluia.",
                latin : "*Ps 103:30*\nAllelúja, allelúja. Emítte Spiritum tuum, et creabúntur: et renovábis fáciem terræ. Allelúja.\nVeni, Sancte Spiritus, reple tuórum corda fidélium: et tui amóris in eis ignem accénde. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 14:23-31*\nAt that time Jesus said to His disciples If any one love Me, he will keep My word, and My Father will love him, and We will come to him and will make Our abode in him: he that loveth Me not keepeth not My words. And the word which you have heard is not Mine; but the Father’s who sent Me. These things have I spoken to you, abiding with you. But the Paraclete, the Holy Ghost, whom the Father will send in My name, He will teach you all things, and bring all things to your mind, whatsoever I shall have said to you. Peace I leave with you, My peace I give unto you: not as the world giveth, do I give unto you. Let not your heart be troubled, nor let it be afraid. You have heard that I said to you: I go away, and I come unto you. If you loved Me, you would indeed be glad, because I go to the Father: for the Father is greater than I. And now I have told you before it come to pass: that when it shall come to pass you may believe. I will not now speak many things with you. For the prince of this world cometh, and in Me he hath not any thing. But that the world may know that I love the Father, and as the Father hath given Me commandment so do I.",
                latin : "*Jn 14:23-31*\nIn illo témpore: Dixit Jesus discípulis suis: Si quis díligit me, sermónem meum servábit, et Pater meus díliget eum, et ad eum veniémus et mansiónem apud eum faciémus: qui non díligit me, sermónes meos non servat. Et sermónem quem audístis, non est meus: sed ejus, qui misit me, Patris. Hæc locútus sum vobis, apud vos manens. Paráclitus autem Spíritus Sanctus, quem mittet Pater in nómine meo, illo vos docébit ómnia et súggeret quæcúmque díxero vobis. Pacem relínquo vobis, pacem  meam do vobis: non quómodo mundus dat, ego do vobis. Non turbétur cor vestrum neque formídet. Audístis quia ego dixi vobis: Vado et venio ad vos. Si diligerétis me, gauderétis útique, quia vado ad Patrem: quia Pater major me est. Et nunc dixi vobis priúsquam fiat: ut cum factum fúerit, credátis. Jam non multa loquar vobíscum. Venit enim princeps mundi hujus, et in me non habet quidquam. Sed ut cognóscat mundus, quia díligo Patrem, et sicut mandátum dedit mihi Pater, sic fácio."
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 67:29,30*\nConfirm, O God, what Thou hast wrought in us; from Thy temple, which is in Jerusalem, kings shall offer presents to Thee.",
                latin : "*Ps 67:29,30*\nConfírma hoc, Deus, quod operátus es in nobis: a templo tuo, quod est in Jerúsalem, tibi ófferent reges múnera."
            ),
            PropersData (
                title : "Secret",
                english : "Sanctify, we beseech Thee, O Lord, the gifts which we offer Thee, and cleanse our hearts by the light of the Holy Ghost.\nThrough our Lord...in the unity of the same Holy Ghost...",
                latin : "Múnera quǽsumus, Dómine, obláta sanctífica: et corda nostra Sancti Spíritus illustratióne emúnda.\nPer Dóminum...in unitáte ejúsdem Spíritus Sancti..."
            ),
            PropersData (
                title : "Preface of the Holy Ghost",
                english : "It is truly meet and just, right and for our salvation, that we should at all times, and in all places, give thanks unto Thee, O holy Lord, Father almighty, everlasting God: through Christ our Lord. Who ascending above all in the heavens and sitting at Thy Right Hand, poured out the Holy Spirit upon the children of adoption. Wherefore the whole world doth rejoice with overflowing joy; and the heavenly Hosts also and the angelic Powers sing together the hymn of Thy glory, evermore saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: per Christum, Dóminum nostrum. Qui, ascéndens super omnes cælos sedénsque ad déxteram tuam, promíssum Spíritum Sanctum * * in fílios adoptiónis effúdit. Quaprópter profúsis gáudiis totus in orbe terrárum mundus exsúltat. Sed et supérnæ Virtútes atque angélicæ Potestátes hymnum glóriæ tuæ cóncinunt, sine fine dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Acts 2:2,4*\nSuddenly there came a sound from heaven, as of a mighty wind coming where they were sitting, alleluia; and they were all filled with the Holy Ghost, speaking the wonderful works of God.",
                latin : "*Acts 2:2,4*\nFactus est repénte de cœlo sonus, tamquam adveniéntis spíritus veheméntis, ubi erant sedéntes, allelúia: et repléti sunt omnes Spíritu Sancto, loquéntes magnália Dei."
            ),
            PropersData (
                title : "Postcommunion",
                english : "May the outpouring of the Holy Ghost purify our hearts, O Lord, and by the inward sprinkling of His heavenly dew may they be made fruitful.\nThrough our Lord...in the unity of the same Holy Ghost...",
                latin : "Sancti Spíritus, Dómine, corda nostra mundet infúsio: et sui roris íntima aspersióne fœcúndet.\nPer Dóminum...in unitáte ejúsdem Spíritus Sancti..."
            )
        ],
        commemorations : []
    ),
    "The Most Holy Sacrament of the Eucharist - Thursday" : CelebrationData (
        rank : 4,
        title : "The Blessed Sacrament",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 80:17*\nHe fed them with the fat of corn, alleluia, and filled them with honey out of the rock, alleluia, alleluia, alleluia.\n*Ps 80:2*\nRejoice to God our helper; sing aloud to the God of Jacob.\nGlory be to the Father...\nHe fed them with the fat of corn, alleluia, and filled them with honey out of the rock, alleluia, alleluia, alleluia.",
                latin : "*Ps 80:17*\nCibavit eos ex ádipe fruménti, allelúia: et de petra, melle saturávit eos, allelúia, allelúia, allelúia.\n*Ps 80:2*\nExsultáte Deo adjutório nostro; jubiláte Deo Jacob.\nGlória Patri...\nCibavit eos ex ádipe fruménti, allelúia: et de petra, melle saturávit eos, allelúia, allelúia, allelúia."
            ),
            PropersData (
                title : "Collect",
                english : "O God, Who in this wonderful sacrament has left us a memorial of Thy passion: grant us, we beseech Thee, so to venerate the sacred mysteries of Thy Body and Blood, that we may ever perceive within us the fruit of Thy redemption.\nWho livest...",
                latin : "Deus, qui nobis sub Sacraménto mirábili passiónis tuæ memóriam reliquísti: tríbue, quǽsumus, ita nos Córporis et Sánguinis tui sacra mystéria venerári; ut redemptiónis tuæ fructum in nobis júgiter sentiámus:\nQui vivis..."
            ),
            PropersData (
                title : "Lesson",
                english : "*1 Cor 11:23-29*\nBrethren, I have received of the Lord, that which also I delivered to you, that the Lord Jesus, the same night in which He was betrayed, took bread, and giving thanks, broke, and said: Take ye and eat, this is My Body which shall be delivered for you; this do for the commemoration of Me. In like manner also the chalice, after He had supped, saying: This chalice is the new testament in My Blood; this do ye, as often as you shall drink, for the commemoration of Me. For as often as you shall eat this bread and drink this chalice, you shall show the death of the Lord until He come. Therefore whosoever shall eat this bread, or drink of the chalice of the Lord unworthily, shall be guilty of the Body and the Blood of the Lord. But let a man prove himself; and so let him eat of that bread, and drink of the chalice. For he that eateth and drinketh unworthily, eateth and drinketh judgment to himself, not discerning the Body of the Lord.",
                latin : "*1 Cor 11:23-29*\nFratres: Ego enim accépi a Dómino quod et trádidi vobis, quóniam Dóminus Jesus, in qua nocte tradebátur, accépit panem, et grátias agens, fregit, et dixit: Accípite et manducáte: hoc est corpus meum, quod pro vobis tradétur: hoc fácite in meam commemoratiónem. Simíliter et cálicem, postquam cœnávit, dicens: Hic calix novum testaméntum est in meo sánguine. Hoc fácite, quotiescúmque bibétis, in meam commemoratiónem. Quotiescúmque enim manducábitis panem hunc et cálicem bibétis, mortem Dómini annuntiábitis, donec véniat. Itaque quicúmque manducáverit panem hunc, vel bíberit cálicem Dómini indígne, reus erit córporis et sánguinis Dómini. Probet autem seípsum ho­ mo: et sic de pane illo edat et de cálice bibat. Qui enim mandúcat et bibit indígne, judícium sibi mandúcat et bibit: non dijúdicans corpus Dómini."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 144:15-16*\nThe eyes of all hope in Thee, O Lord, and Thou givest them meat in due season. Thou openest Thy hand, and fillest every living creature with Thy blessing.",
                latin : "*Ps 144:15-16*\nOculi ómnium in te sperant, Dómine: et tu das illis escam in témpore opportuno. Aperis tu manum tuam: et imples omne ánimal benedictióne."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Jn 6:56,57*\nAlleluia, alleluia. My Flesh is meat indeed, and My Blood is drink indeed: he that eateth My Flesh and drinketh My Blood, abideth in Me, and I in him. Alleluia.",
                latin : "*Jn 6:56,57*\nAllelúja, allelúja. Caro mea vere est cibus, et sanguis meus vere est potus: qui mandúcat meam carnem, et bibit meum sánguinem, in me manet et ego is eo. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Malachi 1:11; Prov 9:5*\nFrom the rising of the sun even to its going down, My name is great among the Gentiles. And in every place there is sacrifice, and there is offered to My name a clean oblation; for My name is great among the Gentiles. Come, eat My bread: and drink the wine, which I have mingled for you.",
                latin : "*Malachi 1:11; Prov 9:5*\nAb ortu solis usque ad occasum, magnum est nomen meum in gentibus. Et in omni loco sacrificatur, et offertur nomini meo oblatio munda: quia magnum est nomen meum in gentibus. Venite, comedite panem meum: et bibite vinium, quod miscue vobis."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Lk 24:35*\nAlleluia, alleluia. The disciples knew the Lord Jesus in the breaking of bread. Alleluia.\n*Jn 6:56,57*\nLet us bless the Father and the Son with the Holy Ghost. Alleluia.",
                latin : "*Lk 24:35*\nAllelúja, allelúja. Cognovérunt discípuli Dóminum Jesum in fractióne panis. Allelúja.\n*Jn 6:56,57*\nCaro mea vere est cibus, et sanguis meus vere est potus: qui mandúcat meam carnem, et bibit meum sánguinem, in me manet et ego is eo. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 6:56-59*\nAt that time Jesus said to the multitudes of the Jews: My Flesh is meat indeed, and My Blood is drink indeed. He that eateth My Flesh, and drinketh My Blood, abideth in Me, and I in him. As the living Father hath sent Me, and I live by the Father, so he that eateth Me, the same also shall live by Me. This is the bread that came down from Heaven. Not as your fathers did eat manna and are dead. He that eateth this Bread shall live for ever.",
                latin : "*Jn 6:56-59*\nIn illo témpore: Dixit Jesus turbis Judæórum: Caro mea vere est cibus, et sanguis meus vere est potus. Qui mandúcat meam carnem et bibit meum sánguinem, in me manet et ego in illo. Sicut misit me vivens Pater, et ego vivo propter Patrem: et qui mandúcat me, et ipse vivet propter me. Hic est panis, qui de cælo descéndit. Non sicut manducavérunt patres vestri manna, et mórtui sunt. Qui mandúcat hunc panem, vivet in ætérnum."
            ),
            PropersData (
                title : "Offertory",
                english : "*Lev 21:6*\nThe priests of the Lord offer incense and loaves to God, and therefore they shall be holy to their God, and shall not defile His name. Alleluia.",
                latin : "*Lev 21:6*\nSacerdótes Dómini incénsum et panes ófferunt Deo: et ídeo sancti erunt Deo suo, et non pólluent nomen ejus. Allelúia."
            ),
            PropersData (
                title : "Secret",
                english : "We beseech Thee, O Lord, mercifully grant to Thy Church the gifts of unity and peace, which are mystically shown forth in the offerings now made.\nThrough our Lord...",
                latin : "Eeelésiæ tuæ, quǽsumus, Dómine, unitátis et pacis propítius dona concéde: quæ sub oblátis munéribus mýstice designántur.\nPer Dóminum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*1 Cor 11:26,27*\nAs often as you shall eat this Bread and drink the Chalice, you shall show the death of the Lord until He come: therefore whosoever shall eat this Bread or drink the Chalice of the Lord unworthily, shall be guilty of the Body and Blood of the Lord. Allelluia.",
                latin : "*1 Cor 11:26,27*\nQuotiescúmque manducábitis panem hunc, et cálicem bibétis, mortem Dómini annuntiábitis donec véniat: ítaque quicúmque manducáverit panem vel bíberit cálicem Dómimi indígne: reus erit córporis et sánguinis Dómini. Allelúia."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Grant us, we beseech Thee, O Lord, to be filled with the everlasting enjoyment of Thy divinity which is prefigured by the reception in this life of Thy precious Body and Blood:\nWho livest...",
                latin : "Fac nos, quǽsumus, Dómine, divinitátis tuæ sempitérna fruitióne repléri: quam pretiósi Córporis et Sánguinis tui temporális percéptio præfigúrat:\nQui vivis..."
            )
        ],
        commemorations : []
    ),
    "The Passion of the Lord - Friday" : CelebrationData (
        rank : 4,
        title : "The Passion",
        colors : "r",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Phil 2:8-9*\nThe Lord Jesus Christ humbled Himself unto death, even the death of the cross; wherefore God also exalted Him and hast given Him a name which is above every name.\n*Ps 88:2*\nThe mercies of the Lord I will sing for ever: to generation and generation.\nGlory be to the Father...\nThe Lord Jesus Christ humbled Himself unto death, even the death of the cross; wherefore God also exalted Him and hast given Him a name which is above every name.",
                latin : "*Phil 2:8-9*\nHumiliavit semetipsum Dominus Jesus Christus usque ad mortem, mortem autem crucis: propter quod et Deus exaltavit illum, et donavit illi nomen, quod est super omne nomen.\n*Ps 88:2*\nMisericordias Domini in æternum cantabo: in generationem et generationem.\nGlória Patri...\nHumiliavit semetipsum Dominus Jesus Christus usque ad mortem, mortem autem crucis: propter quod et Deus exaltavit illum, et donavit illi nomen, quod est super omne nomen."
            ),
            PropersData (
                title : "Collect",
                english : "O Lord Jesus Christ, Who didst come down to earth from the bosom of Thy heavenly Father, and didst shed Thy precious Blood to wash away our sins: we humbly beseech Thee, that on the judgment day, at Thy right hand, we may be found worthy to hear from Thee those words: Come, ye blessed:\nWho with the same God the Father and the Holy Ghost, livest and reignest, God, world without end...",
                latin : "Domine Jesu Christe, qui de cælis ad terram de sinu Patris descendisti, et sanguinem tuum pretiosum in remissionem peccatorum nostrorum fudisti: te humiliter deprecamur; ut in die judicii, ad dexteram tuam audire mereamur: Venite benedicti:\nQui cum eodem Deo Patre et Spiritu Sancto vivis et regnas, Deus, per omnia sæcula sæculorum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Zach 12:10-11; 13:6-7*\nThus saith the Lord: I will pour out upon the house of David, and upon the inhabitants of Jerusalem, the spirit of grace and of prayers: and they shall look upon Me, Whom they have pierced: and they shall mourn for Him as one mourneth for an only son, and they shall grieve over Him as the manner is to grieve for the death of the first-born. In that day there shall be a great lamentation in Jerusalem, and it shall be said: What are these wounds in the midst of Thy hands? And He shall say: With these I was wounded in the house of them that loved Me. Awake, O sword, against my Shepherd, and against the man that cleaveth to Me, saith the Lord of hosts: strike the shepherd, and the sheep shall be scattered: saith the Lord almighty.",
                latin : "*Zach 12:10-11; 13:6-7*\nHæc dicit Dominus: Effundam super domum David, et super habitatores Jerusalem, spiritum gratiæ et precum: et aspiciem ad me, quem confixerunt: et plangent eum planctu quasi super unigenitum et dolebunt super eum, ut doleri solet in morte primogeniti. In die illa magnus erit planctus in Jerusalem, et dicetur: Quid sunt plagæ istæ in medio manuum tuarum? Et dicet: His plagatus sum in domo eorum, qui diligebant me. Framea suscitare super pastorem meum, et super virum cohærentem mihi, dicit Dominus exercituum: percute pastorem, et dispergentur oves, ait Dominus omnipotens."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 68:21-22*\nMy heart hath expected reproach and misery: and I looked for one that would grieve together with Me, and there was none: I sought one that would comfort Me, and I found none. They gave Me gall for My food, and in My thirst they gave Me vinegar to drink.",
                latin : "*Ps 68:21-22*\nImproperium exspectavit cor meum, et miseriam: et sustinui, qui simul mecum contristaretur, et non fuit: consolantem me quæsivi, et non inveni. Dederunt in escam meam fei, et in siti mea potaverunt me aceto."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. Hail, Thou our King: Thou alone hast had compassion on our errors: obedient to the Father, Thou wert led to be crucified like a meek lamb to the slaughter. Alleluia.",
                latin : "Allelúja, allelúja. Ave, Rex noster, tu solus nostros es miseratus errores: Patri obediens, ductus es ad crucifigendum, ut agnus mansuetus ad occisionem. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Is 52:4-5*\nSurely He hath borne our infirmities, and carried our sorrows. And we have thought Him as it were a leper, and as one struck by God and afflicted. But He was wounded for our iniquities, He was bruised for our sins. The chastisement of our peace was upon Him: and by His bruises we are healed.",
                latin : "*Is 52:4-5*\nVere languores nostros ipse tulit, et dolores nostros ipse portavit. Et nos putavimus eum quasi leprosum, et percussum Deo, et humiliatum. Ipse autem vulneratus est, propter iniquitates nostras, attritus est propter scelera nostra. Disciplina pacis nostræ super eum: et livore ejus sanati sumus."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "Alleluia, alleluia. Hail, Thou our King: Thou alone hast had compassion on our errors: obedient to the Father, Thou wert led to be crucified like a meek lamb to the slaughter. Alleluia.\nTo thee be glory, hosanna: to Thee be triumph and victory: to Thee a crown of highest praise and honour. Alleluia.",
                latin : "Allelúja, allelúja. Ave, Rex noster, tu solus nostros es miseratus errores: Patri obediens, ductus es ad crucifigendum, ut agnus mansuetus ad occisionem. Allelúja.\nTibi gloria, hosanna: tibi triumphus et victoria: tibi summæ laudis et honoris corona. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 19:28-35*\nAt that time: Jesus knowing that all things were now accomplished, that the Scripture might be fulfilled, said: I thirst. Now there was a vessel set there full of vinegar. And they putting a sponge full of vinegar about hyssop, put it to His mouth. Jesus therefore when He had taken the vinegar, said: It is consummated. And bowing His head He gave up the ghost. Then the Jews (because it was the parasceve), that the bodies might not remain upon the cross on the sabbath day (for that was the great sabbath day), besought Pilate that their legs might be broken, and that they might be taken away. The soldiers, therefore, came: and they broke the legs of the first, and of the other that was crucified with Him. But after they were come to Jesus, when they saw that He was already dead, they did not break His legs. But one of the soldiers with a spear opened His side, and immediately there came out blood and water. And he that saw it hath given testimony, and his testimony is true.",
                latin : "*Jn 19:28-35*\nIn illo tempore: Sciens Jesus quia omnia consummata sunt, ut consummaretur Scriptura, dixit: Sitio. Vas ergo erat positum aceto plenum. Illi autem spongiam plenum aceto, hyssopo circumponentes, obtulerunt ori ejus. Cum ergo accepisset Jesus acetum, dixit: Consummatum est. Et inclinato capite tradidit spiritum. Judaei ergo (quoniam Parasceve erat) ut non remanerent in cruce corpora sabbato (erat enim magnus dies ille sabbati), rogaverunt Pilatum ut frangerentur eorum crura, et tollerentur. Venerunt ergo milites: et primi quidem fregerunt crura, et alterius qui crucifixus est cum eo. Ad Jesum autem cum venissent, ut viderunt eum jam mortuum, non fregerunt ejus crura, sed unus militum lancea latus ejus aperuit, et continuo exivit sanguis et aqua. Et qui vidit, testimonium perhibuit: et verum est testimonium ejus."
            ),
            PropersData (
                title : "Offertory",
                english : "Wicked men rose up against Me: pitilessly they sought to kill Me: they even spat in My face; with their spears they wounded Me, and all My bones were shaken.",
                latin : "Insurrexerunt in me viri iniqui: absque misericordia quæsierunt me interficere: et non pepercerunt in faciem meam spuere: lanceis suis vulneraverunt me, et concussa sunt omnia ossa mea."
            ),
            PropersData (
                title : "Secret",
                english : "May the Sacrifice which we offer up to Thee, O Lord, ever quicken and guard us through the Passion of Thine only-begotten Son.\nWho with Thee liveth and reigneth...",
                latin : "Oblatum tibi Domine sacrificium, intercedente unigeniti Filii tui Passione, vivificet nos semper et muniat:\nQui tecum vivit et regnat..."
            ),
            PropersData (
                title : "Preface of the Holy Cross",
                english : "It is truly meet and just, right and for our salvation, that we should at all times, and in all places, give thanks unto Thee, O holy Lord, Father almighty, everlasting God; Who didst establish the salvation of mankind on the tree of the Cross; that whence death came, thence also life might arise again, and that he, who overcame by the tree, by the tree also might be overcome: Through Christ our Lord. Through whom the Angels praise Thy Majesty, the Dominations worship it, the Powers stand in awe. The Heavens and the heavenly hosts together with the blessed Seraphim in triumphant chorus unite to celebrate it. Together with these we entreat Thee that Thou mayest bid our voices also to be admitted while we say with lowly praise:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Qui salútem humáni géneris in ligno Crucis constituísti: ut, unde mors oriebátur, inde vita resúrgeret: et, qui in ligno vincébat, in ligno quoque vincerétur: per Christum, Dóminum nostrum. Per quem majestátem tuam laudant Angeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Ps 21:1,8*\nThey have pierced My hands and My feet: they have numbered all My bones.",
                latin : "*Ps 21:1,8*\nFoderunt manus meas, et pedes meos: dinumeraverunt omnia ossa mea."
            ),
            PropersData (
                title : "Postcommunion",
                english : "O Lord Jesus Christ, Son of the living God, Who at the sixth hour didst mount the gibbet of the cross for the redemption of the world, and didst shed Thy precious Blood that our sins might be washed away: we humbly entreat Thee that after our death Thou wouldst grant us joyfully to enter the gates of heaven:\nWho livest and reignest...",
                latin : "Domine Jesu Christe, Fili Dei vivi, qui hora sexta pro redemptione mundi crucis patibulum ascendisti, et sanguinem tuum pretiosum in remissionem peccatorum nostrorum fudisti: te humilter deprecamur; ut post obitum nostrum paradisi januas nos gaudenter introire concedas:\nQui vivis et regnas..."
            )
        ],
        commemorations : []
    ),
    "The Holy Cross - Friday" : CelebrationData (
        rank : 4,
        title : "The Holy Cross",
        colors : "r",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Gal 6:14*\nBut it behooves us to glory in the cross of Our Lord Jesus Christ: in Whom is our salvation, life, and resurrection; by Whom we are saved and delivered, (P.T. Alleluia, alleluia.)\n*Ps 66:2*\nMay God have mercy on us, and bless us; may He cause the light of His countenance to shine upon us, and may He have mercy on us.\nGlory be to the Father...\nBut it behooves us to glory in the cross of Our Lord Jesus Christ: in Whom is our salvation, life, and resurrection; by Whom we are saved and delivered. (P.T. Alleluia, alleluia.)",
                latin : "*Gal 6:14*\nNos autem gloriári opórtet in Cruce Dómini nostri Jesu Christi: in quo est salus, vita et resurréctio nostra: per quem salváti et liberáti sumus. (T.P. Allelúja, allelúja.)\n*Ps 66:2*\nDeus misereátur nostri, et benedícat nobis: illúminet vultum suum super nos, et misereátur nostri.\nGlória Patri...\nNos autem gloriári opórtet in Cruce Dómini nostri Jesu Christi: in quo est salus, vita et resurréctio nostra: per quem salváti et liberáti sumus. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect (Paschaltide)",
                english : "O God, Who wast pleased to sanctify the standard of the life-giving cross with the blood of Thine only-begottten Son, Grant, we beseech Thee, that those who rejoice in honoring the same holy cross may also everywhere rejoice in Thy protection.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Deus, qui unigéniti Fílii tui pretióso sanguine vivíficæ Crucis vexíllum sanctificáre voluísti: concéde, quǽsumus; eos, qui ejusdem sanctæ Crucis gaudent honóre, tua quoque ubíque protectióne gaudére.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Collect (Not Paschaltide)",
                english : "O God, Who didst will that for our sakes Thy Son should undergo the torment of the cross, to free us from the power of the enemy, grant us, Thy servants, that we may attain unto the glory of the resurrection.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Deus, qui pro nobis Fílium tuum Crucis patíbulum subíre voluísti, ut inimíci a nobis expélleres potestátem: concéde nobis, fámulis tuis; ut resurrectiónis grátiam consequámur.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Phil 2:8-11*\nBrethren: Christ became for us obedient unto death, even to the death of the cross. For which cause God also hath exalted Him, and hath given Him a Name which is above all names:\n\n(here all kneel)\n\nthat in the Name of Jesus every knee should bow, of those that are in Heaven, on earth, and under the earth and that every tongue should confess that the Lord Jesus Christ is in the glory of God the Father.",
                latin : "*Phil 2:8-11*\nFratres: Christus factus est pro nobis obǿdiens usque ad mortem, mortem autem crucis. Propter quod et Deus exaltávit illum, et donávit illi nomen, quod est super omne nomen:\n\n(hic genuflectitur)\n\nut in nómine Jesu omne genu flectátur coeléstium, terréstrium et infernórum, et omnis lingua confiteátur, quia Dóminus Jesus Christus in glória est Dei Patris."
            ),
            PropersData (
                title : "Gradual",
                english : "*Phil 2:8,9*\nChrist became obedient for us unto death: even the death of the cross. For which cause also God hath exalted Him and hath given Him a name which is above all names.",
                latin : "*Phil 2:8,9*\nChristus factus est pro nobis obǿdiens usque ad mortem, mortem autem crucis. Propter quod et Deus exaltávit illum, et dedit illi nomen, quod est super omne nomen."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. Sweet the wood, sweet the nails, sweet the load that hangs thereon: to bear up the King and Lord of Heaven nought was worthy save thou, O holy cross. Alleluia.",
                latin : "Allelúja, allelúja. Dulce lignum, dulces clavos, dúlcia ferens póndera: quæ sola fuísti digna sustinére Regem coelórum et Dóminum. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "We adore Thee, O Christ, and we bless Thee, because by Thy cross Thou didst redeem the world. We adore Thy cross, O Lord, we commemorate Thy glorious passion; have mercy on us, Thou Who didst suffer for us. O blessed cross, that alone wast worthy to bear the Lord and king of the heavens.",
                latin : "Adorámus te, Christe, et benedícimus tibi: quia per Crucem tuam redemísti mundum. Tuam Crucem adorámus, Dómine, tuam gloriósam recólimus passiónem: miserére nostri, qui passus es pro nobis. O Crux benedícta, quæ sola fuisti digna portáre Regem cælórum et Dóminum."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 95:10*\nAlleluia, alleluia. Say ye among the gentiles, that the Lord hath reigned from the wood. Alleluia. Sweet the wood, sweet the nails, sweet the burden they bore, for thou alone, O Tree, wast deemed worthy to bear Him Who is Lord and king of heaven. Alleluia.",
                latin : "*Ps 95:10*\nAllelúja, allelúja. Dícite in géntibus, quia Dóminus regnávit a ligno. Allelúja. Dulce lignum, dulces clavos, dúlcia ferens póndera: quæ sola fuísti digna sustinére Regem cælórum et Dóminum. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Matt 20:17-19*\nAt that time: Jesus took the twelve disciples apart, and said to them: Behold we go up to Jerusalem, and the Son of man shall be betrayed to the chief priests and the scribes, and they shall condemn Him to death. And shall deliver Him to the gentiles to be mocked, and scourged, and crucified, and the third day He shall rise again.",
                latin : "*Matt 20:17-19*\nIn illo témpore: Assúmpsit Jesus duódecim discípulos secréto, et ait illis: Ecce, ascéndimus Jerosólymam, et Fílius hóminis tradétur princípibus sacerdótum et scribis, et condemnábunt eum morte, et tradent eum Géntibus ad illudéndum, et flagellándum, et crucifigéndum, et tértia die resúrget."
            ),
            PropersData (
                title : "Offertory",
                english : "Through the sign of the holy cross, protect Thy people, O Lord, from the snares of all enemies, that we may pay Thee a pleasing service, and our sacrifice be acceptable, (P.T. Alleluia.)",
                latin : "Prótege, Dómine, plebem tuam per signum sanctæ Crucis ab ómnibus insídiis inimicórum ómnium: ut tibi gratam exhibeámus servitútem, et acceptábile fiat sacrifícium nostrum. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Secret",
                english : "May this oblation, we beseech Thee, O Lord, purge us of all our offenses, as upon the altar of the cross, it took away the sins of the whole world.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Hæc oblátio, Dómine, quǽsumus, ab ómnibus nos purget offénsis: quæ in ara Crucis étiam totíus mundi tulit offénsam.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Preface of the Holy Cross",
                english : "It is truly meet and just, right and for our salvation, that we should at all times and in all places, give thanks unto Thee, O holy Lord, Father almighty, everlasting God Who didst establish the salvation of mankind on the tree of the Cross that whence death came, thence also life might rise again, and that he, who overcame by the tree, by the tree also might be overcome: Through Christ our Lord. Through Whom the Angels praise Thy majesty, the Dóminations worship it, the Powers stand in awe. The heavens and the heavenly hosts together with the blessed Seraphim in triumphant chorus unite to celebrate it. Together with these we entreat Thee, that Thou mayest bid our voices also to be admitted while we say with lowly praise:",
                latin : "Vere dignum et justum est, æqum et salutáre, nos tibi semper, et ubique grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus. Qui salútem húmani géneris in ligno crucis constituísti: ut, unde mors oriebátur, inde vita resúrgeret: et qui in ligno vincébat, in ligno quoque vincerétur, per Christum Dóminum nostrum. Per quem majestátem tuam laudant Angeli, adórant Dóminatiónes, tremunt Potestátes coeli coelorúmque Virtútes, ac beáta Séraphim, sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admitti júbeas deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Ps 78:2,11*\nThrough the sign of the cross deliver us from our enemies, O our God. (P.T. Alleluia.)",
                latin : "*Ps 78:2,11*\nPer signum Crucis de inimícis nostris líbera nos, Deus noster. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "Be Thou with us, O Lord. our God, and as Thou dost make us rejoice in honor of the holy cross, defend us also by its perpetual assistance.\nThrough our Lord...",
                latin : "Adésto nobis, Dómine, Deus noster: et quos sanctæ Crucis lætári facis honóre, ejus quoque perpétuis defénde subsídiis.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "Our Lady (Advent)" : CelebrationData (
        rank : 4,
        title : "Our Lady (Advent)",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Isa 45:8*\nDrop down dew, ye heavens, from above, and let the clouds rain the just: let the earth be opened and bud forth a Savior.\n*Ps 84:2*\nLord, Thou hast blessed Thy land: Thou hast turned away the captivity of Jacob.\nGlory be to the Father...\nDrop down dew, ye heavens, from above, and let the clouds rain the just: let the earth be opened and bud forth a Savior.",
                latin : "*Isa 45:8*\nRoráte, cæli, désuper, et nubes pluant justum: aperiátur terra, et gérminet Salvatórem.\n*Ps 84:2*\nBenedixísti, Domine, terram tuam: avertísti captivitátem Jacob.\nGlória Patri...\nRoráte, cæli, désuper, et nubes pluant justum: aperiátur terra, et gérminet Salvatórem."
            ),
            PropersData (
                title : "Collect",
                english : "O God, Who didst will that at the message of an Angel, Thy Word should take flesh in the womb of the blessed Virgin Mary, grant that we, Thy suppliants, who believe her to be truly the Mother of God, may be helped by her intercession with Thee.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Deus, qui de beátæ Maríæ Vírginis útero Verbum tuum, Angelo nuntiánte, carnem suscípere voluísti: præsta supplícibus tuis; ut, qui vere eam Genetrícem Dei crédimus, ejus apud te intercessiónibus adjuvémur.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Isa 7:10-15*\nIn those days, the Lord spoke to Achaz, saying: Ask thee a sign of the Lord thy God, either unto the depth of hell, or unto the height above. And Achaz said: I will not ask, and I will not tempt the Lord. And He said: Hear ye therefore, O house of David: Is it a small thing for you to be grievous to men, that you are grievous to my God also? Therefore the Lord Himself shall give you a sign. Behold a Virgin shall conceive, and bear a Son, and His name shall be called Emmanuel. He shall eat butter and honey, that He may know to refuse the evil, and to choose the good.",
                latin : "*Isa 7:10-15*\nIn diébus illis: Locútus est Dóminus ad Achaz, dicens: Pete tibi signum a Dómino Deo tuo, in profúndum inférni, sive in excélsum supra. Et dixit Achaz: Non petam et non tentábo Dóminum. Et dixit: Audíte ergo, domus David: Numquid parum vobis est, moléstos esse homínibus, quia molesti estis et Deo meo ? Propter hoc dabit Dóminus ipse vobis signum. Ecce, virgo concípiet, et páriet fílium, et vocábitur nomen ejus Emmánuel. Butýrum et mel cómedet, ut sciat reprobáre malum, et elígere bonum."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 23:7*\nLift up your gates, O ye princes; and be ye lifted up, O eternal gates: and the King of glory shall enter in.\n*Ps 23:3-4*\nWho shall .ascend into the mountain of the Lord, or who shall stand in His holy place? The innocent in hands and clean of heart.",
                latin : "*Ps 23:7*\nTóllite portas, príncipes, vestras: et elevámini, portæ æternáles: et introíbit Rex glóriæ.\n*Ps 23:3-4*\nQuis ascéndet in montem Dómini, aut quis stabit in loco sancto ejus? Innocens mánibus et mundo corde."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Lk 1:28*\nAlleluia, alleluia. Hail Mary, full of grace, the Lord is with thee: blessed art thou among women. Alleluia.",
                latin : "*Lk 1:28*\nAllelúja, allelúja. Ave, María, grátia plena: Dóminus tecum: benedícta tu in muliéribus. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 1:26-38*\nAt that time the Angel Gabriel was sent from God into a city of Galilee, called Nazareth, to a virgin espoused to a man whose name was Joseph, of the house of David, and the virgin's name was Mary. And the Angel being come in, said unto her: Hail, full of grace: the Lord is with thee: blessed art thou among women. Who having heard, was troubled at his saying: and thought with herself what manner of salutation this should be. And the Angel said to her: Fear not, Mary, for thou hast found grace with God: behold thou shalt conceive in thy womb, and shall bring forth a son, and thou shalt call His name Jesus. He shall be great, and shall be called the Son of the Most High, and the Lord God shall give unto Him the throne of David His father; and He shall reign in the house of Jacob for ever, and of His kingdom there shall be no end. And Mary said to the Angel: How shall this be done, because I know not man? And the Angel answering, said to her: The Holy Spirit shall come upon thee, and the power of the Most High shall overshadow thee. And therefore also the Holy which shall be born of thee shall be called the Son of God. And behold thy cousin Elizabeth, she also hath conceived a son in her old age; and this is the sixth month with her that is called barren; because no work shall be impossible with God. And Mary said: Behold the handmaid of the Lord, be it done to me according to thy word.",
                latin : "*Lk 1:26-38*\nIn illo témpore: Missus est Ángelus Gábriël a Deo in civitátem Galilǽæ, cui nomen Názareth, ad Vírginem desponsátam viro, cui nomen erat Joseph, de domo David, et nomen Vírginis María. Et ingréssus Ángelus ad eam, dixit: Ave grátia plena: Dóminus tecum: benedícta tu in muliéribus. Quæ cum audísset, turbáta est in sermóne ejus: et cogitábit qualis esset ista salutátio. Et ait Ángelus ei: Ne tímeas, María, invenísti enim grátiam apud Deum: ecce concípies in útero, et páries fílium, et vocábis nomen ejus Jesum. Hic erit magnus, et Fílius Altíssimi vocábitur, et dabit illi Dóminus Deus sedem David patris ejus: et regnábit in domo Jacob in ætérnum, et regni ejus non erit finis. Dixit autem María ad Angelum: Quómodo fiet istud, quóniam virum non cognósco? Et respóndens Ángelus, dixit ei: Spíritus Sanctus supervéniet in te, et virtus Altíssimi obumbrábit tibi. Ideóque et quod nascétur ex te Sanctum, vocábitur Fílius Dei. Et ecce, Elísabeth, cognáta tua, et ipsa concépit fílium in senectúte sua:et hic mensis sextus est illi, quæ vocátur stérilis: quia non erit impossíbile apud Deum omne verbum. Dixit autem María: Ecce ancílla Dómini, fiat mihi secúndum verbum tuum."
            ),
            PropersData (
                title : "Offertory",
                english : "*Lk 1:28,42*\nHail Mary, full of grace; the Lord is with thee. Blessed art thou among women, and blessed is the fruit of thy womb.",
                latin : "*Lk 1:28,42*\nAve, María, grátia plena: Dóminus tecum: benedícta tu in muliéribus, et benedíctus fructus ventris tui."
            ),
            PropersData (
                title : "Secret",
                english : "Strengthen in our minds, O Lord, we beseech Thee, the mysteries of the true faith: that confessing Him Who was conceived of the Virgin to be true God and true man, we may deserve, through the power of His saving resurrection, to attain everlasting joy.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "In méntibus nostris, quǽsumus, Dómine, veræ fídei sacraménta confírma: ut, qui concéptum de Vírgine Deum verum et hóminem confitémur: per ejus salutíferæ resurrectiónis poténtiam, ad ætérnam mereámur perveníre lætítiam.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData (
                title : "Preface of the Blessed Virgin Mary",
                english : "It is truly meet and just, right and for our salvation that we always and everywhere give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should praise and bless, and proclaim Thee, in veneration of the Blessed Mary, ever Virgin: Who also conceived Thine only-begotten Son by the overshadowing of the Holy Spirit, and the glory of her virginity still abiding, gave forth to the world the everlasting Light, Jesus Christ our Lord. Through Whom the Angels praise Thy Majesty, the Dominations adore it, the Powers tremble: the heavens and the hosts of heaven, and the blessed Seraphim, together celebrate in exultation. With whom, we pray Thee, command that our voices of supplication also be joined in acknowledging Thee saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in Veneratióne beátæ Maríæ semper Vírginis collaudáre, benedícere et prædicáre. Quæ et Unigénitum tuum Sancti Spíritus obumbratióne concépit: et, virginitátis glória permanénte, lumen ætérnum mundo effúdit, Jesum Christum, Dóminum nostrum. Per quem maiestátem tuam laudant Ángeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "*Isa 7:14*\nBehold, a virgin shall conceive, and bring forth a son; and His name shall be called Emmanuel.",
                latin : "*Isa 7:14*\nEcce Virgo concípiet et páriet fílium: et vocábitur nomen ejus Emmánuel."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Pour forth, we beseech Thee, O Lord, Thy grace into our hearts: that we, to whom the incarnation of Christ Thy Son was made known by the message of an Angel, may, by His passion and cross, be brought to the glory of His Resurrection.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Grátiam tuam, quǽsumus, Dómine, méntibus nostris infúnde: ut qui, Ángelo nuntiánte, Christi Fílii tui, incarnatiónem cognóvimus; per passiónem ejus et crucem, ad resurrectiónis glóriam perducámur.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            )
        ],
        commemorations : []
    ),
    "Our Lady (Before the Purification)" : CelebrationData (
        rank : 4,
        title : "Our Lady (Before the Purification)",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 44:13,15-16*\nAll the rich among the people shall entreat Thy countenance: after her shall virgins be brought to the King: her neighbors shall be brought to thee in gladness and rejoicing.\n*Ps 44:2*\nMy heart hath uttered a good word: I speak my works to the King.\nGlory be to the Father...\nAll the rich among the people shall entreat Thy countenance: after her shall virgins be brought to the King: her neighbors shall be brought to thee in gladness and rejoicing.",
                latin : "*Ps 44:13,15-16*\nVultum tuum deprecabúntur omnes dívites plebis: adducántur Regi Vírgines post eam: próximæ eius adducéntur tibi in lætítia et exsultatióne.\n*Ps 44:2*\nEructávit cor meum verbum bonum: dico ego ópera mea Regi.\nGlória Patri...\nVultum tuum deprecabúntur omnes dívites plebis: adducántur Regi Vírgines post eam: próximæ eius adducéntur tibi in lætítia et exsultatióne."
            ),
            PropersData (
                title : "Collect",
                english : "O God, who by the fruitful virginity of blessed Mary hast bestowed upon mankind the rewards of eternal salvation: grant, we beseech Thee, that we may experience her intercession for us, through whom we have been made worthy to receive the Author of Life, Jesus Christ Thy Son, our Lord: Who lives and reigns with Thee in the unity of the Holy Spirit, God, forever and ever.",
                latin : "Deus, qui salútis ætérnæ, beátæ Maríæ virginitáte foecúnda, humáno generi praemia præstitísti: tríbue, quaesumus; ut ipsam pro nobis intercédere sentiámus, per quam merúimus auctórem vitæ suscípere, Dóminum nostrum Jesum Christum, Fílium tuum:\nQui tecum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Tit.3:4-7*\nDearly beloved: the goodness and kindness of God our Savior appeared: not by the works of justice which we have done, but according to His mercy He saved us by the laver of regeneration and renovation of the Holy Ghost, whom He hath poured forth upon us abundantly through Jesus Christ our Savior: that, being justified by His grace, we may be heirs according to hope of life everlasting: in Christ Jesus our Lord.",
                latin : "*Tit.3:4-7*\nCaríssime: Appáruit benígnitas et humánitas Salvatóris nostri Dei: non ex opéribus iustítiæ, quæ fécimus nos, sed secúndum suam misericórdiam salvos nos fecit, per lavácrum regeneratiónis et renovatiónis Spíritus Sancti, quem effúdit in nos abúnde per Iesum Christum, Salvatórem nostrum: ut, iustificáti grátia ipsíus, herédes simus secúndum spem vitæ ætérnæ: in Christo Iesu, Dómino nostro."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 44:3,2*\nThou art beautiful above the sons of men: grace is poured abroad in Thy lips. V. My heart hath uttered a good word: I speak my works to the king: my tongue is the pen of a scrivener that writeth swiftly.",
                latin : "*Ps 44:3,2*\nSpeciósus forma præ fíliis hóminum: diffúsa est grátia in lábiis tuis. V. Eructávit cor meum verbum bonum: dico ego ópera mea Regi: lingua mea cálamus scribæ velóciter scribéntis."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. V. After childbirth thou didst remain a virgin: O Mother of God, intercede for us. Alleluia.",
                latin : "Allelúja, allelúja. V. Post partum, Virgo, invioláta permansísti: Dei Génetrix, intercéde pro nobis. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "Rejoice, O Virgin Mary, thou alone hast destroyed all heresies. Who didst believe the words of the Archangel Gabriel. Whilst a virgin thou didst bring forth God and man: and after childbirth thou didst remain a pure virgin. O Mother of God, intercede for us.",
                latin : "Gaude, María Virgo, cunctas hæréses sola interemísti. Quæ Gabriélis Archángeli dictis credidísti. Dum Virgo Deum et hóminem genuísti: et post partum Virgo invioláta permansísti. Dei Génetrix, intercéde pro nobis."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 2:15-20*\nAt that time, the shepherds said one to another: Let us go over to Bethlehem, and let us see this word that is come to pass, which the Lord hath showed to us. And they came with haste: and they found Mary and Joseph, and the Infant lying in the manger. And seeing they understood of the word that had been spoken to them concerning this Child. And all that heard wondered: and at those things that were told them by the shepherds. But Mary kept all these words, pondering them in her heart. And the shepherds returned, glorifying and praising God for all the things they had heard and seen, as it was told unto them.",
                latin : "*Lk 2:15-20*\nIn illo témpore: Pastóres loquebántur ad ínvicem: Transeámus usque Béthlehem, et videámus hoc verbum, quod factum est, quod Dóminus osténdit nobis. Et venérunt festinántes, et invenérunt Maríam, et Joseph, et Infántem pósitum in præsépio. Vidéntes autem cognovérunt de verbo, quod dictum erat illis de Púero hoc. Et omnes, qui audiérunt, miráti sunt: et de his, quæ dicta erant a pastóribus ad ipsos. María autem conservábat ómnia verba hæc, cónferens in corde suo. Et revérsi sunt pastores, glorificántes et laudántes Deum in ómnibus, quæ audíerant et víderant, sicut dictum est ad illos."
            ),
            PropersData (
                title : "Offertory",
                english : "For thou art happy, O holy Virgin Mary, and most worthy of all praise: because from thee arose the sun of justice, Christ, our God.",
                latin : "Felix namque es, sacra Virgo María, et omni laude digníssima: quia ex te ortus est sol iustítiæ, Christus, Deus noster."
            ),
            PropersData (
                title : "Secret",
                english : "By Thy gracious mercy, O Lord, and the intercession of blessed Mary ever Virgin, may this offering be of avail to us for welfare and peace now and for evermore.\nThrough our Lord...",
                latin : "Dómine, propitiatióne, et beátæ Maríæ semper Vírginis intercessióne, ad perpétuam atque præséntem hæc oblátio nobis profíciat prosperitátem et pacem.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Preface of the Blessed Virgin Mary",
                english : "It is truly meet and just, right and for our salvation that we always and everywhere give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should praise and bless, and proclaim Thee, in veneration of the Blessed Mary, ever Virgin: Who also conceived Thine only-begotten Son by the overshadowing of the Holy Spirit, and the glory of her virginity still abiding, gave forth to the world the everlasting Light, Jesus Christ our Lord. Through Whom the Angels praise Thy Majesty, the Dominations adore it, the Powers tremble: the heavens and the hosts of heaven, and the blessed Seraphim, together celebrate in exultation. With whom, we pray Thee, command that our voices of supplication also be joined in acknowledging Thee saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in Veneratióne beátæ Maríæ semper Vírginis collaudáre, benedícere et prædicáre. Quæ et Unigénitum tuum Sancti Spíritus obumbratióne concépit: et, virginitátis glória permanénte, lumen ætérnum mundo effúdit, Jesum Christum, Dóminum nostrum. Per quem maiestátem tuam laudant Ángeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "Blessed is the womb of the Virgin Mary, which bore the Son of the Eternal Father.",
                latin : "Beáta víscera Maríæ Vírginis, quæ portavérunt ætérni Patris Fílium."
            ),
            PropersData (
                title : "Postcommunion",
                english : "May this Communion, O Lord, cleanse us from guilt: and through the intercession of the blessed Virgin Mary, Mother of God, make us sharers of the heavenly remedy.\nThrough the same Jesus Christ, Thy Son, our Lord...",
                latin : "Hæc nos commúnio, Dómine, purget a crímine: et, intercedénte beáta Vírgine Dei Genetríce María, coeléstis remédii fáciat esse consórtes.\nPer eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            )
        ],
        commemorations : []
    ),
    "Our Lady (Before Holy Thursday)" : CelebrationData (
        rank : 4,
        title : "Our Lady (Before Holy Thursday)",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Sedulius; Ps 44:2*\nHail, holy Mother, thou who didst bring forth the King who rules heaven and earth for ever and ever.\n*Ps 44: 2*\nMy heart hath uttered a good word: I speak my works to the King.\nGlory be to the Father...\nHail, holy Mother, thou who didst bring forth the King who rules heaven and earth for ever and ever.",
                latin : "*Sedulius; Ps 44:2*\nSalve, sancta Parens, eníxa puérpera Regem: qui cælum terrámque regit in sǽcula sæculórum.\n*Ps 44: 2*\nEructávit cor meum verbum bonum: dico ego ópera mea Regi.\nGlória Patri...\nSalve, sancta Parens, eníxa puérpera Regem: qui cælum terrámque regit in sǽcula sæculórum."
            ),
            PropersData (
                title : "Collect",
                english : "Grant us Thy servants, we beseech Thee, O Lord God, to enjoy perpetual health of mind and body; and by the glorious intercession of blessed Mary ever Virgin, to be delivered from present sorrows and to enjoy everlasting gladness.\nThrough our Lord...",
                latin : "Concéde nos fámulos tuos, quǽsumus, Dómine Deus, perpétua mentis et córporis sanitáte gaudére: et, gloriósa beátæ Maríæ semper Vírginis intercessióne, a præsénti liberári tristítia et ætérna pérfrui lætítia.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Ecc 24:14-16*\nFrom the beginning, and before the world, was I created, and unto the world to come I shall not cease to be, and in the holy dwelling place I have ministered before him. And so I was established in Sion, and in the holy city likewise I rested, and my power was in Jerusalem. And I took root in an honorable people, and in the portion of my God his inheritance, and my abode is in the full assembly of saints.",
                latin : "*Ecc 24:14-16*\nAb inítio et ante sǽcula creáta sum, et usque ad futúrum sǽculum non désinam, et in habitatióne sancta coram ipso ministrávi. Et sic in Sion firmáta sum, et in civitáte sanctificáta simíliter requiévi, et in Jerúsalem potéstas mea. Et radicávi in pópulo honorificáto, et in parte Dei mei heréditas illíus, et in plenitúdine sanctórum deténtio mea."
            ),
            PropersData (
                title : "Gradual",
                english : "Thou art blessed and venerable, O Virgin Mary, who with purity unstained was found to be the Mother of our Savior. Virgin Mother of God, He whom the whole world was unable to contain enclosed Himself in thy womb, being made man.",
                latin : "Benedícta et venerábilis es, Virgo María: quæ sine tactu pudóris invénta es Mater Salvatóris. Virgo, Dei Génetrix, quem totus non capit orbis, in tua se clausit víscera factus homo."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Num 17:8*\nAlleluia, alleluia. The rod of Jesse hath blossomed: a Virgin hath brought forth Him Who is God and man: God hath restored peace, reconciling in Himself the lowest with the highest. Alleluia.",
                latin : "*Num 17: 8*\nAllelúja, allelúja. Virga Jesse flóruit: Virgo Deum et hóminem génuit: pacem Deus réddidit, in se reconcílians ima summis. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "Rejoice, O Virgin Mary, thou alone hast destroyed all heresies. Who didst believe the words of the Archangel Gabriel. Whilst a virgin thou didst bring forth God and man: and after childbirth thou didst remain a pure virgin. O Mother of God, intercede for us.",
                latin : "Gaude, María Virgo, cunctas hæréses sola interemísti. Quæ Gabriélis Archángeli dictis credidísti. Dum Virgo Deum et hóminem genuísti: et post partum Virgo invioláta permansísti. Dei Génetrix, intercéde pro nobis."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 11:27-28*\nAt that time, as Jesus was speaking to the multitudes, a certain woman from the crowd, lifting up her voice, said to Him: Blessed is the womb that bore Thee and the paps that gave Thee suck. But He said: Yea, rather, blessed are they who hear the word of God and keep it.",
                latin : "*Lk 11:27-28*\nIn illo témpore: Loquénte Jesu ad turbas, extóllens vocem quædam múlier de turba, dixit illi: Beátus venter, qui te portávit, et úbera, quæ suxísti. At ille dixit: Quinímmo beáti, qui áudiunt verbum Dei, et custódiunt illud."
            ),
            PropersData (
                title : "Offertory",
                english : "For thou art happy, O holy Virgin Mary, and most worthy of all praise: because from thee arose the sun of justice, Christ our Lord.",
                latin : "Felix namque es, sacra Virgo María, et omni laude digníssima: quia ex te ortus est sol justítiæ, Christus Deus noster."
            ),
            PropersData (
                title : "Secret",
                english : "By Thy gracious mercy, O Lord, and the intercession of blessed Mary ever Virgin, may this offering be of avail to us for welfare and peace now and for evermore.\nThrough our Lord...",
                latin : "Tua, Dómine, propitiatióne, et beátæ Maríæ semper Vírginis intercessióne, ad perpétuam atque præséntem hæc oblátio nobis profíciat prosperitátem et pacem.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Preface of the Blessed Virgin Mary",
                english : "It is truly meet and just, right and for our salvation that we always and everywhere give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should praise and bless, and proclaim Thee, in veneration of the Blessed Virgin Mary, ever Virgin: Who also conceived Thine only-begotten Son by the overshadowing of the Holy Spirit, and the glory of her virginity still abiding, gave forth to the world the everlasting Light, Jesus Christ our Lord. Through Whom the Angels praise Thy majesty, the Dominations adore, the Powers tremble: the heavens and the hosts of heaven, and the blessed Seraphim, together celebrate in exultation. With whom, we pray Thee, command that our voices of supplication also be admitted in confessing Thee saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in Veneratióne beátæ Maríæ semper Vírginis collaudáre, benedícere et prædicáre. Quæ et Unigénitum tuum Sancti Spíritus obumbratióne concépit: et, virginitátis glória permanénte, lumen ætérnum mundo effúdit, Jesum Christum, Dóminum nostrum. Per quem maiestátem tuam laudant Ángeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "Blessed is the womb of the Virgin Mary, which bore the Son of the Eternal Father.",
                latin : "Beáta víscera Maríæ Vírginis, quæ portavérunt ætérni Patris Fílium."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Having received, O Lord, these helps to our salvation, grant, we beseech Thee, that we may be ever protected by the patronage of blessed Mary ever Virgin, in whose honor we have made these offerings to Thy majesty.\nThrough our Lord...",
                latin : "Sumptis, Dómine, salútis nostræ subsídiis: da, quǽsumus, beátæ Maríæ semper Vírginis patrocíniis nos ubíque prótegi; in cujus veneratióne hæc tuæ obtúlimus majestáti.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "Our Lady (Paschaltide/Ascensiontide)" : CelebrationData (
        rank : 4,
        title : "Our Lady (Paschaltide/Ascensiontide)",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Sedulius; Ps 44:2*\nHail, holy Mother, thou who didst bring forth the King who rules heaven and earth for ever and ever.\n*Ps 44: 2*\nMy heart hath uttered a good word: I speak my works to the King.\nGlory be to the Father...\nHail, holy Mother, thou who didst bring forth the King who rules heaven and earth for ever and ever.",
                latin : "*Sedulius; Ps 44:2*\nSalve, sancta Parens, eníxa puérpera Regem: qui cælum terrámque regit in sǽcula sæculórum.\n*Ps 44: 2*\nEructávit cor meum verbum bonum: dico ego ópera mea Regi.\nGlória Patri...\nSalve, sancta Parens, eníxa puérpera Regem: qui cælum terrámque regit in sǽcula sæculórum."
            ),
            PropersData (
                title : "Collect",
                english : "Grant us Thy servants, we beseech Thee, O Lord God, to enjoy perpetual health of mind and body; and by the glorious intercession of blessed Mary ever Virgin, to be delivered from present sorrows and to enjoy everlasting gladness.\nThrough our Lord...",
                latin : "Concéde nos fámulos tuos, quǽsumus, Dómine Deus, perpétua mentis et córporis sanitáte gaudére: et, gloriósa beátæ Maríæ semper Vírginis intercessióne, a præsénti liberári tristítia et ætérna pérfrui lætítia.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Ecc 24:14-16*\nFrom the beginning, and before the world, was I created, and unto the world to come I shall not cease to be, and in the holy dwelling place I have ministered before him. And so I was established in Sion, and in the holy city likewise I rested, and my power was in Jerusalem. And I took root in an honorable people, and in the portion of my God his inheritance, and my abode is in the full assembly of saints.",
                latin : "*Ecc 24:14-16*\nAb inítio et ante sǽcula creáta sum, et usque ad futúrum sǽculum non désinam, et in habitatióne sancta coram ipso ministrávi. Et sic in Sion firmáta sum, et in civitáte sanctificáta simíliter requiévi, et in Jerúsalem potéstas mea. Et radicávi in pópulo honorificáto, et in parte Dei mei heréditas illíus, et in plenitúdine sanctórum deténtio mea."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "Alleluia, alleluia. The rod of Jesse hath blossomed: a Virgin hath brought forth God and man: God hath restored peace, reconciling in Himself the lowest with the highest. Alleluia. Hail Mary, full of grace: the Lord is with thee: blessed art thou among women. Alleluia.",
                latin : "Allelúja, allelúja. Virga Jesse floruit: Virgo Deum et hominem genuit: pacem Deus reddidit, in se reconcilians ima summis. Allelúja. Ave María, grátia plena: Dóminus tecum: benedícta tu in muliéribus. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 19:25-27*\nAt that time, there stood by the cross of Jesus, His Mother and His Mother's sister, Mary of Cleophas, and Mary Magdalen. When Jesus therefore had seen His Mother and the disciple standing whom He loved, He saith to His Mother: Woman, behold thy son. After that He saith to the disciple: Behold thy Mother. And from that hour the disciple took her to his own.",
                latin : "*Jn 19:25-27*\nIn illo témpore: Stabant juxta crucem Jesu mater ejus, et soror matris ejus Maria Cléophæ, et María Magdaléne. Cum vidísset ergo Jesus matrem, et dicípulum stantem, quem diligébat, dicit matri suæ: Múlier, ecce fílius tuus. Deínde dicit discípulo: Ecce mater tua. Et ex illa hora accépit eam discípulus in sua."
            ),
            PropersData (
                title : "Offertory",
                english : "*Lk 1:28, 42*\nBlessed art thou, O Virgin Mary, who didst bear the Creator of all things, didst bring forth Him Who made thee, and forever remainest a virgin. Alleluia.",
                latin : "*Lk 1:28, 42*\nBeáta es, Virgo María, quæ ómnium portásti Creatórem: genuísti qui te fecit, et in ætérnum pérmanes Virgo, allelúja."
            ),
            PropersData (
                title : "Secret",
                english : "By Thy gracious mercy, O Lord, and the intercession of blessed Mary ever Virgin, may this offering be of avail to us for welfare and peace now and for evermore.\nThrough our Lord...",
                latin : "Tua, Dómine, propitiatióne, et beátæ Maríæ semper Vírginis intercessióne, ad perpétuam atque præséntem hæc oblátio nobis profíciat prosperitátem et pacem.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Preface of the Blessed Virgin Mary",
                english : "It is truly meet and just, right and for our salvation that we always and everywhere give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should praise and bless, and proclaim Thee, in veneration of the Blessed Virgin Mary, ever Virgin: Who also conceived Thine only-begotten Son by the overshadowing of the Holy Spirit, and the glory of her virginity still abiding, gave forth to the world the everlasting Light, Jesus Christ our Lord. Through Whom the Angels praise Thy majesty, the Dominations adore, the Powers tremble: the heavens and the hosts of heaven, and the blessed Seraphim, together celebrate in exultation. With whom, we pray Thee, command that our voices of supplication also be admitted in confessing Thee saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in Veneratióne beátæ Maríæ semper Vírginis collaudáre, benedícere et prædicáre. Quæ et Unigénitum tuum Sancti Spíritus obumbratióne concépit: et, virginitátis glória permanénte, lumen ætérnum mundo effúdit, Jesum Christum, Dóminum nostrum. Per quem maiestátem tuam laudant Ángeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "Blessed is the womb of the Virgin Mary, which bore the Son of the Eternal Father.",
                latin : "Beáta víscera Maríæ Vírginis, quæ portavérunt ætérni Patris Fílium."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Having received, O Lord, these helps to our salvation, grant, we beseech Thee, that we may be ever protected by the patronage of blessed Mary ever Virgin, in whose honor we have made these offerings to Thy majesty.\nThrough our Lord...",
                latin : "Sumptis, Dómine, salútis nostræ subsídiis: da, quǽsumus, beátæ Maríæ semper Vírginis patrocíniis nos ubíque prótegi; in cujus veneratióne hæc tuæ obtúlimus majestáti.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "Our Lady (Before Advent)" : CelebrationData (
        rank : 4,
        title : "Our Lady (Before Advent)",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Sedulius; Ps 44:2*\nHail, holy Mother, thou who didst bring forth the King who rules heaven and earth for ever and ever.\n*Ps 44:2*\nMy heart hath uttered a good word: I speak my works to the King.\nGlory be to the Father...\nHail, holy Mother, thou who didst bring forth the King who rules heaven and earth for ever and ever.",
                latin : "*Sedulius; Ps 44:2*\nSalve, sancta Parens, eníxa puérpera Regem: qui cælum terrámque regit in sǽcula sæculórum.\n*Ps 44:2*\nEructávit cor meum verbum bonum: dico ego ópera mea Regi.\nGlória Patri...\nSalve, sancta Parens, eníxa puérpera Regem: qui cælum terrámque regit in sǽcula sæculórum."
            ),
            PropersData (
                title : "Collect",
                english : "Grant us Thy servants, we beseech Thee, O Lord God, to enjoy perpetual health of mind and body; and by the glorious intercession of blessed Mary ever Virgin, to be delivered from present sorrows and to enjoy everlasting gladness.\nThrough our Lord...",
                latin : "Concéde nos fámulos tuos, quǽsumus, Dómine Deus, perpétua mentis et córporis sanitáte gaudére: et, gloriósa beátæ Maríæ semper Vírginis intercessióne, a præsénti liberári tristítia et ætérna pérfrui lætítia.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Ecc 24:14-16*\nFrom the beginning, and before the world, was I created, and unto the world to come I shall not cease to be, and in the holy dwelling place I have ministered before him. And so I was established in Sion, and in the holy city likewise I rested, and my power was in Jerusalem. And I took root in an honorable people, and in the portion of my God his inheritance, and my abode is in the full assembly of saints.",
                latin : "*Ecc 24:14-16*\nAb inítio et ante sǽcula creáta sum, et usque ad futúrum sǽculum non désinam, et in habitatióne sancta coram ipso ministrávi. Et sic in Sion firmáta sum, et in civitáte sanctificáta simíliter requiévi, et in Jerúsalem potéstas mea. Et radicávi in pópulo honorificáto, et in parte Dei mei heréditas illíus, et in plenitúdine sanctórum deténtio mea."
            ),
            PropersData (
                title : "Gradual",
                english : "Thou art blessed and venerable, O Virgin Mary, who with purity unstained was found to be the Mother of our Savior. Virgin Mother of God, He whom the whole world was unable to contain enclosed Himself in thy womb, being made man.",
                latin : "Benedícta et venerábilis es, Virgo María: quæ sine tactu pudóris invénta es Mater Salvatóris. Virgo, Dei Génetrix, quem totus non capit orbis, in tua se clausit víscera factus homo."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "Alleluia, alleluia. After childbirth thou didst still remain an inviolate virgin: Mother of God, intercede for us. Alleluia.",
                latin : "Allelúja, allelúja. Post partum, Virgo, invioláta permansísti: Dei Génetrix, intercéde pro nobis. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 11:27-28*\nAt that time, as Jesus was speaking to the multitudes, a certain woman from the crowd, lifting up her voice, said to Him: Blessed is the womb that bore Thee and the paps that gave Thee suck. But He said: Yea, rather, blessed are they who hear the word of God and keep it.",
                latin : "*Lk 11:27-28*\nIn illo témpore: Loquénte Jesu ad turbas, extóllens vocem quædam múlier de turba, dixit illi: Beátus venter, qui te portávit, et úbera, quæ suxísti. At ille dixit: Quinímmo beáti, qui áudiunt verbum Dei, et custódiunt illud."
            ),
            PropersData (
                title : "Offertory",
                english : "*Lk 1:28, 42*\nBlessed art thou, O Virgin Mary, who didst bear the Creator of all things, didst bring forth Him Who made thee, and forever remainest a virgin. Alleluia.",
                latin : "*Lk 1:28, 42*\nBeáta es, Virgo María, quæ ómnium portásti Creatórem: genuísti qui te fecit, et in ætérnum pérmanes Virgo, allelúja."
            ),
            PropersData (
                title : "Secret",
                english : "By Thy gracious mercy, O Lord, and the intercession of blessed Mary ever Virgin, may this offering be of avail to us for welfare and peace now and for evermore.\nThrough our Lord...",
                latin : "Tua, Dómine, propitiatióne, et beátæ Maríæ semper Vírginis intercessióne, ad perpétuam atque præséntem hæc oblátio nobis profíciat prosperitátem et pacem.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Preface of the Blessed Virgin Mary",
                english : "It is truly meet and just, right and for our salvation that we always and everywhere give thanks unto Thee, O holy Lord, Father almighty, everlasting God: and that we should praise and bless, and proclaim Thee, in veneration of the Blessed Virgin Mary, ever Virgin: Who also conceived Thine only-begotten Son by the overshadowing of the Holy Spirit, and the glory of her virginity still abiding, gave forth to the world the everlasting Light, Jesus Christ our Lord. Through Whom the Angels praise Thy majesty, the Dominations adore, the Powers tremble: the heavens and the hosts of heaven, and the blessed Seraphim, together celebrate in exultation. With whom, we pray Thee, command that our voices of supplication also be admitted in confessing Thee saying:",
                latin : "Vere dignum et justum est, æquum et salutáre, nos tibi semper et ubíque grátias ágere: Dómine sancte, Pater omnípotens, ætérne Deus: Et te in Veneratióne beátæ Maríæ semper Vírginis collaudáre, benedícere et prædicáre. Quæ et Unigénitum tuum Sancti Spíritus obumbratióne concépit: et, virginitátis glória permanénte, lumen ætérnum mundo effúdit, Jesum Christum, Dóminum nostrum. Per quem maiestátem tuam laudant Ángeli, adórant Dominatiónes, tremunt Potestátes. Cæli cælorúmque Virtútes ac beáta Séraphim sócia exsultatióne concélebrant. Cum quibus et nostras voces ut admítti júbeas, deprecámur, súpplici confessióne dicéntes:"
            ),
            PropersData (
                title : "Communion",
                english : "Blessed is the womb of the Virgin Mary, which bore the Son of the Eternal Father.",
                latin : "Beáta víscera Maríæ Vírginis, quæ portavérunt ætérni Patris Fílium."
            ),
            PropersData (
                title : "Postcommunion",
                english : "Having received, O Lord, these helps to our salvation, grant, we beseech Thee, that we may be ever protected by the patronage of blessed Mary ever Virgin, in whose honor we have made these offerings to Thy majesty.\nThrough our Lord...",
                latin : "Sumptis, Dómine, salútis nostræ subsídiis: da, quǽsumus, beátæ Maríæ semper Vírginis patrocíniis nos ubíque prótegi; in cujus veneratióne hæc tuæ obtúlimus majestáti.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "For Peace" : CelebrationData (
        rank : 4,
        title : "For Peace",
        colors : "v",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ecc 36:18*\nGive peace, O Lord, to them that patiently wait for Thee, that Thy prophets may be found faithful: hear the prayers of Thy servant, and of Thy people Israel. (P. T. Aileluia, alleluia.)\n*Ps 121:1*\nI rejoiced at the things that were said to me: We shall go into the house of the Lord.\nGlory be to the Father...\nGive peace, O Lord, to them that patiently wait for Thee, that Thy prophets may be found faithful: hear the prayers of Thy servant, and of Thy people Israel. (P.T. Alleluia, alleluia.)",
                latin : "*Ecc 36:18*\nDa pacem, Dómine, sustinéntibus te, ut prophétæ tui fidéles inveniántur: exáudi preces servi tui, et plebis tuæ Israël. (T.P. Allelúja, allelúja.)\n*Ps 121:1*\nLætátus sum in his, quæ dicta sunt mihi: in domum Dómini íbimus.\nGlória Patri...\nDa pacem, Dómine, sustinéntibus te, ut prophétæ tui fidéles inveniántur: exáudi preces servi tui, et plebis tuæ Israël. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, from Whom are holy desires, right counsels, and just works, give to Thy servants that peace which the world cannot give; that our hearts being devoted to the keeping of Thy commandments, and the fear of enemies removed, our times, by Thy protection, may be peaceful.\nThrough our Lord...",
                latin : "Deus, a quo sancta desidéria, recta consília et justa sunt ópera: da servis tuis illam, quam mundus dare non potest, pacem; ut et corda nostra mandátis tuis dédita, et, hóstium subláta formídine, témpora sint, tua protectióne, tranquílla.\nPer Dóminum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*2 Mach 1:1-5*\nTo the brethren, the Jews that are throughout Egypt, the brethren, the Jews that are in Jerusalem, and in the land of Judea, send health, and good peace. May God be gracious to you, and remember His covenant that He made with Abraham, and Isaac, and Jacob, His faithful servants: And give you all a heart to worship Him and to do His wllI with a great heart, and a willing mind. May He open your heart in His law, and in His commandments, and send you peace. May He hear your prayers, and be reconciled unto you, and never forsake you in the evil time.",
                latin : "*2 Mach 1:1-5*\nFrátribus, qui sunt per Ægýptum, Judǽis, salutem dicunt fratres, qui sunt in Jerosólymis, Judǽi et qui in regióne Judǽæ, et pacem bonam. Benefáciat vobis Deus et memínerit testaménti sui, quod locútus est ad Abraham et Isaac et Jacob, servórum suórum fidélium; et det vobis cor ómnibus, ut colátis eum et faciátis ejus voluntátem corde magno et ánimo volénti. Adapériat cor vestrum in lege sua et in præcéptis suis et fáciat pacem. Exáudiat oratiónes vestras et reconciliétur vobis nec vos déserat in témpore malo, Dóminus, Deus noster."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 121:6-7*\nPray ye for the things that are for the peace of Jerusalem: and abundance for them that love thee. Let peace be in Thy strength: and abundance in thy towers.",
                latin : "*Ps 121:6-7*\nRogáte quæ ad pacem sunt Jerúsalem: et abundántia diligéntibus te. Fiat pax in virtúte tua, et abundántia in túrribus tuis."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 147:12*\nAlleluia, alleluia. Praise the Lord, O Jerusalem: praise thy God, O Sion. Alleluia.",
                latin : "*Ps 147:12*\nAllelúja, allelúja. Lauda, Jerúsalem, Dóminum: lauda Deum tuum, Sion. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 75: 2-4*\nIn Judea God is known, His name is great in Israel. And His place is in peace, and His abode in Sion. There hath He broken the power of bows, the shield, the sword, and the battle.",
                latin : "*Ps 75:2-4*\nNotus in Judǽa Deus, in Israël magnum nomen ejus. Et factus est in pace locus ejus, et habitátio ejus in Sion. Ibi confrégit poténtias árcuum, scutum, gládium, et bellum."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 147:12*\nAlleluia, alleluia. Praise the Lord, O Jerusalem: praise thy God, O Sion. Alleluia.\n*Ibid.:14*\nWho hath placed peace in thy borders: and filleth thee with the fat of corn. Alleluia.",
                latin : "*Ps 147:12*\nAllelúja, allelúja. Lauda, Jerúsalem, Dóminum: lauda Deum tuum, Sion. Allelúja.\n*Ibid.:14*\nQui pósuit fines tuos pacem, et ádipe fruménti sátiat te. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Jn 20:19-23*\nAt that time: when it was late, that same day, the first of the week, and the doors were shut, where the disciples were gathered together for fear of the Jews, Jesus came and stood in the midst, and said to them: Peace be to you. And when he had said this, He showed them His hands and His side. The disciples therefore were glad, when they saw the Lord. He said therefore to them again: Peace be to you. As the Father hath sent Me, I also send you. When He had said this, He breathed on them; and said to them: Receive ye the Holy Ghost. Whose sins you shall forgive, they are forgiven them; and whose sins you shall retain, they are retained.",
                latin : "*Jn 20:19-23*\nIn illo témpore: Cum sero esset die illo, una sabbatórum, et fores essent clausæ, ubi erant discípuli congregáti propter metum Judæórum: venit Jesus, et stetit in médio, et dixit eis: Pax vobis. Et cum hoc dixísset, osténdit eis manus et latus. Gavísi sunt ergo discípuli, viso Dómino. Dixit ergo eis íterum: Pax vobis. Sicut misit me Pater, et ego mitto vos. Hæc cum dixísset, insufflávit, et dixit eis: Accípite Spíritum Sanctum: quorum remiséritis peccáta, remittúntur eis: et quorum retinuéritis, reténta sunt."
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 134:3,6*\nPraise ye the Lord, for He is good, sing ye to His name, for it is sweet: Whatsoever He pleased, He hath done in heaven and upon earth (P. T. Alleluia.)",
                latin : "*Ps 134:3,6*\nLaudáte Dóminum, quia benígnus est: psállite nómini ejus, quóniam suávis est: ómnia quæcúmque vóluit, fecit in cœlo et in terra. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Secret",
                english : "O God, Who sufferest not the nations that believe in Thee to be shaken by any fear, deign, we beseech Thee, to receive the prayers and sacrifices of the people consecrated to Thee, that peace, the gift of Thy loving-kindness, may render Christian countries safe from every enemy.\nThrough our Lord...",
                latin : "Deus, qui credéntes in te pópulos nullis sinis cóncuti terróribus: dignáre preces et hóstias dicátæ tibi plebis suscípere; ut pax, a tua pietáte concéssa, Christianórum fines ab omni hoste fáciat esse secúros.\nPer Dóminum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*Jn 14:27*\nMy peace I leave you: My peace I give to you, saith the Lord. (P. T. Alleluia.)",
                latin : "*Jn 14:27*\nPacem relínquo vobis: pacem meam do vobis, dicit Dóminus. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "O God, the Author and Lover of peace, Whom to know is to live, and to serve is to reign; protect Thy suppliants from all assaults, that we who trust in Thy defense, may fear no armed hostility.\nThrough our Lord...",
                latin : "Deus, auctor pacis et amátor, quem nosse vívere, cui servíre regnáre est: prótege ab ómnibus impugnatiónibus súpplices tuos; ut, qui in defensióne tua confídimus, nullíus hostilitátis arma timeámus.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "For Remission of Sins" : CelebrationData (
        rank : 4,
        title : "For Remission of Sins",
        colors : "v",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Sap. 11:24,25,27*\nThou hast mercy upon all, O Lord, and hatest none of the things which Thou hast made; winking at the sins of men for the sake of repentance, and sparing them: for Thou art the Lord our God. (P.T. Alleluia, alleluia.)\n*Ps 56:2*\nHave mercy on me, O God, have mercy on me; for my soul trusteth in Thee.\nGlory be to the Father...\nThou hast mercy upon all, O Lord, and hatest none of the things which Thou hast made; winking at the sins of men for the sake of repentance, and sparing them: for Thou art the Lord our God.",
                latin : "*Sap. 11:24,25,27*\nMiseréris ómnium, Dómine, et nihil odísti eórum, quæ fecísti: dissímulans peccáta hóminum propter pœniténtiam, et parcens illis: quia tu es Dóminus, Deus noster. (T.P. Allelúja, allelúja.)\n*Ps 56:2*\nMiserére mei, Deus, miserére mei: quóniam in te confídit ánima mea.\nGlória Patri...\nMiseréris ómnium, Dómine, et nihil odísti eórum, quæ fecísti: dissímulans peccáta hóminum propter pœniténtiam, et parcens illis: quia tu es Dóminus, Deus noster."
            ),
            PropersData (
                title : "Collect",
                english : "Hear O Lord, we beseech Thee, the prayers of Thy suppliants and punish not the sins of those who confess unto Thee; but in Thy bounty grant us both forgiveness and peace.\nThrough our Lord...",
                latin : "Exáudi, quǽsumus, Dómine, súpplicum preces, et confiténtium tibi parce peccátis: ut páriter nobis indulgéntiam tríbuas benígnus et pacem.\nPer Dóminum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Rom 7:22-25*\nBrethren: l am delighted with the law of God, according to the inward man: but I see another law in my members, fighting against the law of my mind, and captivating me in the law of sin, that is in my members. Unhappy man that I am; Who shall deliver me from the body of this death? The grace of God, by Jesus Christ our Lord.",
                latin : "*Rom 7:22-25*\nFratres: Condeléctor legi Dei secúndum interiórem hóminem: video autem áliam legem in membris meis, repugnántem legi mentis meæ, et captivántem me in lege peccáti, quæ est in membris meis. Infélix ego homo, quis me liberábit de córpore mortis hujus? Grátia Dei per Jesum Christum, Dóminum nostrum."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 78:9-10*\nForgive us our sins, O Lord, lest they should say. among the gentiles, Where is their God? Help us, O God our Saviour; and for the glory of Thy name, O Lord, deliver us.",
                latin : "*Ps 78:9-10*\nPropítius esto, Dómine, peccátis nostris, ne quando dicant gentes: Ubi est Deus eórum? Adjuva nos, Deus, salutáris noster: et propter honórem nóminis tui, Dómine, líbera nos."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 7:12*\nAlleluia, alleluia. God is a just judge, strong and patient: is He angry every day? Alleluia.",
                latin : "*Ps 7:12*\nAllelúja, allelúja. Deus judex justus, fortis et pátiens: numquid irascátur per síngulos dies? Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 129:1-4*\nOut of the depths I have cried to Thee, O Lord; Lord, hear my voice. Let Thine ears be attentive to the prayer of Thy servant. If Thou shalt observe iniquities, O Lord, Lord, who shall endure it? For with Thee is propitiation, and by reason of Thy law I have waited for Thee, O Lord.",
                latin : "*Ps 129:1-4*\nDe profúndis clamávi ad te, Dómine: Dómine, exáudi vocem meam. Fiant aures tuæ intendéntes in oratiónem servi tui. Si iniquitátes observáveris, Dómine: Dómine, quis sustinébit? Quia apud te propitiátio est: et propter legem tuam sustínui te, Dómine."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 7:12*\nAlleluia, alleluia. God is a just judge, strong and patient: is He angry every day? Alleluia\n*Ps 50:10*\nTo my hearing Thou shalt give joy and gladness: and the bones that have been humbled shall rejoice.\nAlleluia.",
                latin : "Allelúja, allelúja.\n*Ps 7:12*\nDeus judex justus, fortis et pátiens: numquid irascétur per síngulos dies?\nAllelúja.\n*Ps 50:10*\nAudítui meo dabis gáudium et lætítiam: et exsultábunt ossa humiliáta.\nAllelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 11:9-13*\nAt that time: Jesus said to His disciples: Ask and it shall be given to you; seek, and you shall find; knock, and it shall be opened to you. For every one that asketh receiveth; and he that seeketh findeth; and to him that knocketh it shall be opened. And which of you if he ask his father bread, will he give him a stone? or a fish, will he for a fish, give him a serpent? Or if he shall ask an egg, will he reach him a scorpion? If you then, being evil know how to give good gifts to your children, how much more will your Father from heaven give the good Spirit to them that ask Him?",
                latin : "*Lk 11:9-13*\nIn illo témpore: Dixit Jesus discípulis suis: Petite, et dabitur vobis; quǽrite, et inveniétis; pulsáte, et aperiétur vobis. Omnis enim, qui pétii, accipit; et qui quærit, invénit; et pulsánti aperietur. Quis autem ex vobis patrem petit panem: numquid lápidem dabit illi? Aut piscem: numquid pro pisce serpéntem dabit illi? Aut si petíerit ovum: numquid pórriget illi scorpiónem? Si ergo vos, cum sitis mali, nostis bona data dare fíliis vestris: quanto magis Pater vester de cœlo dabit spíritum bonum peténtibus se?"
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 101:2*\nO Lord, hear my prayer: and let my cry come unto Thee. (P.T. Alleluia.)",
                latin : "*Ps 101:2*\nDómine, exáudi oratiónem meam: et clamor meus ad te pervéniat. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Secret",
                english : "We offer up to Thee, O Lord, a sacrifice of atonement and praise; that Thou mayest both mercifully pardon our sins and guide our wavering hearts.\nThrough our Lord...",
                latin : "Hóstias tibi, Dómine, placatiónis et laudis offérimus: ut et delícta nostra miserátus absólvas, et nutántia corda tu dírigas.\nPer Dóminum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*Lk 11:9-10*\nAsk, and you shall receive; seek, and you shall find; knock, and it shall be opened to you. For every one that asketh receiveth; and he that seeketh findeth; and to him that knocketh it shall be opened. (P.T. Alleluia.)",
                latin : "*Lk 11:9-10*\nPetite, et accipiétis; quǽrite, et inveniétis; pulsáte, et aperiétur vobis. Omnis enim, qui pétii, áccipit; et qui quærit, invénit; et pulsánti aperiétur. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "Grant, eternal Saviour, that we who by means of this gift receive forgiveness of sins, may henceforth avoid sin.\nThrough our Lord...",
                latin : "Præsta nobis, ætérne Salvátor: ut, percipiéntes hoc múnere véniam peccatórum, deínceps peccáta vitémus.\nPer Dóminum..."
            )
        ],
        commemorations : []
    ),
    "Propagation of the Faith" : CelebrationData (
        rank : 4,
        title : "Propagation of the Faith",
        colors : "v",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 66:2-3*\nMay God have mercy upon us, and bless us: may He cause the light of His countenance to shine upon us, and may He have mercy upon us: that we may know Thy way upon earth, Thy salvation in all nations.\n*Ps 66:4\nLet the people confess to Thee, O God: let all people give praise to Thee.\nGlory be to the Father...\nMay God have mercy upon us, and bless us: may He cause the light of His countenance to shine upon us, and may He have mercy upon us: that we may know Thy way upon earth, Thy salvation in all nations.",
                latin : "*Ps 66:2-3*\nDeus misereátur nostri, et benedícat nobis: illúminet vultum suum super nos, et misereátur nostri: ut cognoscámus in terra viam tuam, in ómnibus géntibus salutáre tuum.\n*Ps 66:4*\nConfiteántur tibi pópuli, Deus: confiteántur tibi pópuli omnes.\nGlória Patri...\nDeus misereátur nostri, et benedícat nobis: illúminet vultum suum super nos, et misereátur nostri: ut cognoscámus in terra viam tuam, in ómnibus géntibus salutáre tuum."
            ),
            PropersData (
                title : "Collect",
                english : "O God, Who willest that all men should be saved and should come to the knowledge of the truth: we beseech Thee, send forth laborers into Thy harvest, and grant them grace to speak Thy word with all boldness, so that Thy word may run and be glorified, and all nations may know Thee, the only God and Him Whom Thou hast sent: even Jesus Christ, Thy Son, our Lord,\nWho lives and reigns...",
                latin : "Deus, qui omnes hómines vis salvos fíeri, et ad agnitiónem veritátis veníre: mitte, quaésumus, operários in messem tuam, et da eis cum omni fidúcia loqui verbum tuum; ut sermo tuus currat et clarificétur, et omnes gentes cognóscant te solum Deum verum, et quem misísti Jesum Christum, Fílium tuum, Dóminum nostrum:\nQui tecum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Ecc 36:1-10,17-19*\nHave mercy upon us, O God of all, and behold us, and show us the light of Thy mercies: and send Thy fear upon the nations that have not sought after Thee: that they may know that there is no God besides Thee, and that they may show forth Thy wonders. Lift up Thy hand over the strange nations, that they may see Thy power. For as Thou hast been sanctified in us in their sight, so Thou shalt be magnified among them in our presence. That they may know Thee, as we also have known Thee, that there is no God besides Thee, O Lord. Renew Thy signs, and work new miracles. Glorify Thy hand, and Thy right arm. Raise up indignation, and pour out wrath. Take away the adversary, and crush the enemy. Hasten the time, and remember the end, that they may declare Thy wonderful works. Give testimony to them that are Thy creatures from the beginning, and raise up the prophecies which the former prophets spoke in Thy name. Reward them that patiently wait for Thee, that Thy prophets may be found faithful: and hear the prayers of Thy servants, according to the blessing of Aaron over Thy people, and direct us into the way of justice, and let all know that dwell upon earth that Thou art God, the beholder of all ages.",
                latin : "*Ecc 36:1-10,17-19*\nMiserére nostri, Deus ómnium, et réspice nos, et osténde nobis lucem miseratiónum tuárum: et immítte timórem tuum super gentes, quæ non exquisiérunt te, ut cognóscant quia non est Deus nisi tu, et enárrent magnália tua. Álleva manum tuam super gentes aliénas, ut vídeant poténtiam tuam. Sicut enim in conspéctu eórum sanctificátus es in nobis, sic in conspéctu nostro magnificáberis in eis, ut cognóscant te, sicut et nos cognóvimus, quóniam non est Deus præter te, Dómine. Ínnova signa, et immúta mirabília. Glorífica manum et brácchium dextrum. Éxcita furórem, et effúnde iram. Tolle adversárium, et afflíge inimícum. Festína tempus, et meménto finis, ut enárrent mirabília tua. Da testimónium his, qui ab inítio creatúræ tuæ sunt, et súscita prædicatiónes, quas locúti sunt in nómine tuo prophétæ prióres. Da mercédem sustinéntibus te, ut prophétæ tui fidéles inveniántur: et exáudi oratiónes servórum tuórum, secúndum benedictiónem Aaron de pópulo tuo, et dírige nos in viam justítiæ, et sciant omnes, qui hábitant terram, quia tu es Deus conspéctor sæculórum."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 66:6-8*\nLet people confess to Thee, O God: let all people give praise to Thee: the earth hath yielded her fruit. May God, our God, bless us, may God bless us: and all the ends of the earth fear Him.",
                latin : "*Ps 66:6-8*\nConfiteántur tibi pópuli, Deus: confiteántur tibi pópuli omnes: terra dedit fructum suum. Benedícat nos Deus, Deus noster, benedícat nos Deus: et métuant eum omnes fines terræ."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 99:1*\nAlleluia, alleluia. O sing joyfully unto God, all the earth, serve ye the Lord with gladness: come into His presence with exceeding joy. Alleluia.",
                latin : "*Ps 99:1*\nAllelúja, allelúja. Jubiláte Deo, omnis terra: servíte Dómino in lætítia: introíte in conspéctu ejus, in exsultatióne. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 95:3-5*\nDeclare the glory of the Lord among the Gentiles: His wonders among all people. For the Lord is great, and exceedingly to be praised: He is to be feared above all gods. For all the gods of the Gentiles are devils: but the Lord made the heavens.",
                latin : "*Ps 95:3-5*\nAnnuntiáte inter gentes glóriam Dómini, in ómnibus pópulis mirabília ejus. Quóniam magnus Dóminus, et laudábilis nimis: terríbilis est super omnes deos. Quóniam omnes dii géntium dæmónia: Dóminus autem cælos fecit."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 99:1-2*\nAlleluia, alleluia.\nO sing joyfully unto God, all the earth, serve ye the Lord with gladness: come into His presence with exceeding joy.\nAlleluia.\nKnow ye, that the Lord He is God: He made us, and not we ourselves.\nAlleluia.",
                latin : "*Ps 99:1-2*\nAllelúja, allelúja.\nJubiláte Deo, omnis terra: servíte Dómino in lætítia: introíte in conspéctu ejus, in exsultatióne.\nAllelúja.\nScitóte quóniam Dóminus ipse est Deus: ipse fecit nos, et non ipsi nos.\nAllelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Matt 9:35-38*\nAt that time, Jesus went about all the cities and towns, teaching in their synagogues, and preaching the gospel of the kingdom, and healing every disease, and every infirmity. And seeing the multitudes, He had compassion on them: because they were distressed, and lying like sheep that have no shepherd. Then He saith to His disciples: the harvest indeed is great, but the laborers are few. Pray ye therefore the Lord of the harvest, that He send forth laborers into His harvest.",
                latin : "*Matt 9:35-38*\nIn illo témpore: Circuíbat Jesus omnes civitátes et castélla, docens in synagógis eórum, et praédicans Evangélium regni, et curans omnem languórem et omnem infirmitátem. Videns autem turbas, misértus est eis: quia erant vexáti, et jacéntes sicut oves non habéntes pastórem. Tunc dicit discípulis suis: Messis quidem multa, operárii autem pauci. Rogáte ergo Dóminum messis, ut mittat operários in messem suam."
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 95:7-9*\nBring unto the Lord, O ye kindred of the Gentiles, bring unto the Lord glory and honor, bring unto the Lord glory unto His Name: bring sacrifices and come into His courts, adore ye the Lord in His holy court.",
                latin : "*Ps 95:7-9*\nAfférte Dómino, pátriæ géntium, afférte Dómino glóriam et honórem, afférte Dómino glóriam nómini ejus: tóllite hóstias, et introíte in átria ejus: adoráte Dóminum in átrio sancto ejus."
            ),
            PropersData (
                title : "Secret",
                english : "Behold, O God, our Protector, and look upon the Face of Thine Anointed, who gave Himself a redemption for us all, and grant that from the rising of the sun even to its going down, Thy Name may be great among the Gentiles, and that in every place there may be sacrifice and a pure oblation offered to Thy Name. Through the same Jesus Christ, Thy Son, our Lord...",
                latin : "Protéctor noster, áspice, Deus, et réspice in fáciem Christi tui, qui dedit redemptiónem semetípsum pro ómnibus: et fac; ut ab ortu solis usque ad occásum magnificétur nomen tuum in géntibus, ac in omni loco sacrificétur et offerátur nómini tuo oblátio munda. Per eúndem Dóminum nostrum Jesum Christum, Fílium tuum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*Ps 116:1-2*\nPraise the Lord all ye nations: praise Him all ye people: for His mercy is confirmed upon us; and the truth of the Lord remaineth for ever.",
                latin : "*Ps 116:1-2*\nLaudáte Dóminum, omnes gentes: laudáte eum, omnes pópuli: quóniam confirmáta est super nos misericórdia ejus, et véritas Dómini manet in ætérnum."
            ),
            PropersData (
                title : "Postcommunion",
                english : "We who are quickened by this gift of our redemption, beseech Thee, O Lord: that by means of this aid to our eternal salvation, the true faith may ever advance.\nThrough our Lord...",
                latin : "Redemptiónis nostræ múnere vegetáti: quaésumus, Dómine; ut, hoc perpétuæ salútis auxílio, fides semper vera profíciat. Per Dóminum..."
            )
        ],
        commemorations : []
    ),
    "On the Anniversary of a Papal Coronation" : CelebrationData (
        rank : 4,
        title : "On the Anniversary of a Papal Coronation",
        colors : "w",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ecc 45:30*\nThe Lord made to him a covenant of peace, and made him a prince: that the dignity of priesthood should be to him for ever.\n*Ps 131:1*\nO Lord, remember David: and all his meekness.\nGlory be to the Father...\nThe Lord made to him a covenant of peace, and made him a prince: that the dignity of priesthood should be to him for ever.",
                latin : "*Ecc 45:30*\nStátuit ei Dóminus testaméntum pacis, et príncipem fecit eum: ut sit illi sacerdótii dígnitas in ætérnum.\n*Ps 131:1*\nMeménto, Dómine, David: et omnis mansuetúdinis ejus.\nGlória Patri...\nStátuit ei Dóminus testaméntum pacis, et príncipem fecit eum: ut sit illi sacerdótii dígnitas in ætérnum."
            ),
            PropersData (
                title : "Collect",
                english : "O God, Shepherd and Ruler of all the faithful, look propitiously upon Thy servant N., whom Thou hast been pleased to appoint pastor over Thy Church, grant, we beseech Thee, that both by word and by example he may edify those over whom he is placed, and, together with the flock committed to his care, may attain unto life everlasting.\nThrough our Lord...",
                latin : "Deus, ómnium fidélium pastor et rector, fámulum tuum N., quem pastórem Ecclésiæ tuæ præésse voluísti, propítius réspice: da ei, quǽsumus, verbo et exémplo, quibus præest, profícere; ut ad vitam, una cum grege sibi crédito, pervéniat sempitérnam.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*1 Pet 1:1-7*\nPeter, an apostle of Jesus Christ, to the strangers dispersed through Pontus, Galatía, Cappadocia, Asia, and Bithynia, elect according to the fore-knowledge of God the Father, unto the sanctification of the Spirit, unto obedience, and sprinkling of the blood of Jesus Christ; grace unto you and peace be multiplied. Blessed be the God and Father of Our Lord Jesus Christ, Who according to His great mercy hath regenerated us unto a lively hope, by the resurrection of Jesus Christ from the dead, unto an inheritance incorruptible and undefiled, and that can not fade, reserved in heaven for you, who by the power of God are kept by faith unto salvation, ready to be revealed in the last time Wherein you shall greatly rejoice, if now you must be for a little time made sorrowful in divers temptations: that the trial of your faith, much more precious than gold (which is tried by the fire), may be found unto praise, and glory, and honour, at the appearing of Jesus Christ our Lord.",
                latin : "*1 Pet 1:1-7*\nPetrus, Apóstolus Jesu Christi, eléctis ádvenis dispersiónis Ponti, Galátiæ, Cappadóciæ, Asiæ et Bithýniæ secúndum præsciéntiam Dei Patris, in sanctificatiónem Spíritus, in obediéntiam, et aspersiónem sánguinis Jesu Christi: grátia vobis et pax multiplicátus Benedíctus Deus et Pater Dómini nostri Jesu Christi, qui secúndum misericórdiam suam magnam regenerávit nos in spem vivam, per resurrectiónem Jesu Christi ex mórtuis, in hereditátem incorruptíbilem et incontaminátam et immarcescíbilem, conservátam in cælis in vobis, qui in virtúte Dei custodímini per fidem in salútem, parátam revelári in témpore novíssimo. In quo exsultábitis, módicum nunc si opórtet contristári in váriis tentatiónibus: ut probátio vestræ fídei multo pretiósior auro quod per ignem probatur inveniátur in laudem et glóriam et honórem, in revelatióne Jesu Christi, Dómini nostri."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 106:32,31*\nLet them exalt him in the church of the people; and praise him in the chair of the ancients. Let the mercies of the Lord give glory to him; and his wonderful works to the children of men.",
                latin : "*Ps 106:32,31*\nExáltent eum in Ecclésia plebis: et in cáthedra seniórum laudent eum. Confiteántur Dómino misericórdiæ ejus; et mirabília ejus fíliis hóminum."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Matt 16:18*\nAlleluia, alleluia. Thou art Peter, and upon this rock I will build my Church. Alleluia.",
                latin : "*Matt 16:18*\nAllelúja, allelúja. Tu es Petrus, et super hanc petram ædificábo Ecclésiam meam. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Matt 16:18-19*\nThou art Peter, and upon this rock I will build My Church, and the gates of hell shall not prevail against it; and I will give to thee the keys of the kingdom of Heaven. Whatsoever thou shalt bind upon earth, it shall be bound also in Heaven; and whatsoever thou shalt loose on earth, it shall be loosed also in Heaven.",
                latin : "*Matt 16:18-19*\nTu es Petrus, et super hanc petram ædificábo Ecclésiam meam. Et portæ ínferi non prævalébunt advérsus eam: et tibi dabo claves regni cælórum. Quodcúmque ligáveris super terram, erit ligátum et in cælis. Et quodcúmque sólveris super terram, erit solútum et in cælis."
            ),
            PropersData (
                title : "Gospel",
                english : "*Matt 16:13-19*\nAt that time, Jesus came into the quarters of Cæsarea Philippi, and He asked His disciples, Saying, Whom do men say that the Son of man is? But they said, Some, John the Baptist, and other some, Elias, and others, Jeremias, or one of the prophets. Jesus saith to them, But whom do you say that I am? Simon Peter answered, Thou art Christ, the Son of the living God. And Jesus answering, said to him, Blessed art thou, Simon Bar-Jona, because flesh and blood hath not revealed it to thee, but My Father Who is in Heaven: and I say to thee, that thou art Peter, and upon this rock I will build My Church, and the gates of hell shall not prevail against it; and to thee I will give the keys of the kingdom of Heaven; and whatsoever thou shalt bind upon earth, it shall be bound also in Heaven; and whatsoever thou shalt loose on earth, it shall be loosed also in Heaven.",
                latin : "*Matt 16:13-19*\nIn illo témpore: Venit Jesus in partes Cæsaréæ Philíppi, et interrogábat discípulos suos, dicens: Quem dicunt hómines esse Fílium hóminis? At illi dixérunt: Alii Joánnem Baptístam, alii autem Elíam, alii vero Jeremíam aut unum ex prophétis. Dicit illis Jesus: Vos autem quem me esse dícitis? Respóndens Simon Petrus, dixit: Tu es Christus, Fílius Dei vivi. Respóndens autem Jesus, dixit ei: Beátus es, Simon Bar Jona: quia caro et sanguis non revelávit tibi, sed Pater meus, qui in cælis est. Et ego dico tibi, quia tu es Petrus, et super hanc petram ædificábo Ecclésiam meam, et portæ ínferi non prævalébunt advérsus eam. Et tibi dabo claves regni cælórum. Et quodcúmque ligáveris super terram, erit ligátum et in cælis: et quodcúmque sólveris super terram, erit solútum et in cælis."
            ),
            PropersData (
                title : "Offertory",
                english : "*Matt 16:18-19*\nThou art Peter, and upon this rock I will build My Church, and the gates of hell shall not prevail against it; and I will give to thee the keys of the kingdom of Heaven.",
                latin : "*Matt 16:18-19*\nTu es Petrus, et super hanc petram ædificábo Ecclésiam meam: et portæ inferi non prævalébunt advérsus eam: et tibi dabo claves regni cælórum."
            ),
            PropersData (
                title : "Secret",
                english : "Favorably accept, we beseech Thee, O Lord, the gifts we offer, and by Thy continual protection govern Thy servant, N., whom Thou hast been pleased to appoint as pastor over Thy Church.\nThrough our Lord...",
                latin : "Oblátis, quǽsumus, Dómine, placáre munéribus: et fámulum tuum N., quem pastórem Ecclésiæ tuæ præésse voluísti, assídua protectióne gubérna.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Preface of the Apostles",
                english : "It is truly meet and just, right and for our salvation, to entreat Thee humbly, O Lord, that Thou wouldst not desert Thy flock, O everlasting Shepherd, but, through Thy blessed Apostles, wouldst keep it under Thy constant protection; that it may be governed by those same rulers, whom as vicars of Thy work, Thou didst set over it to be its pastors. And therefore with Angels and Archangels, with Thrones and Dominations, and with all the hosts of the heavenly army, we sing the hymn of Thy glory, evermore saying:\n\n*Preface of Easter during Paschaltide*",
                latin : "Vere dignum et justum est, æquum et salutáre: Te, Dómine, supplíciter exoráre, ut gregem tuum, Pastor ætérne, non déseras: sed per beátos Apóstolos tuos contínua protectióne custódias. Ut iísdem rectóribus gubernétur, quos óperis tui vicários eídem contulísti præésse pastóres. Et ídeo cum Angelis et Archángelis, cum Thronis et Dominatiónibus cumque omni milítia cœléstis exércitus hymnum glóriæ tuæ cánimus, sine fine dicéntes:\n\n*Preface of Easter during Paschaltide*"
            ),
            PropersData (
                title : "Communion",
                english : "*Matt 16:18*\nThou art Peter, and upon this rock I will build My Church.",
                latin : "*Matt 16:18*\nTu es Petrus, et super hanc petram ædificábo Ecclésiam meam."
            ),
            PropersData (
                title : "Postcommunion",
                english : "We beseech Thee, O Lord, may the partaking of this divine Sacrament protect us, and ever save and defend Thy servant N., whom Thou hast been pleased to appoint as pastor over Thy Church, together with the flock committed to his care.\nThrough our Lord...",
                latin : "Hæc nos, quæsumus, Dómine, divíni sacraménti percéptio prótegat: et fámulum tuum N., quem pastórem Ecclésiæ tuæ præésse voluísti; una cum commísso sibi grege, salvet semper et múniat.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "In Time of Pestilence" : CelebrationData (
        rank : 4,
        title : "In Time of Pestilence",
        colors : "v",
        propers : [
            PropersData (
                title : "Introit",
                english : "*2 Kings 24:16*\nBe mindful, O Lord, of Thy covenant, and say to the destroying angel. Now hold thy hand, and let not the land be made desolate, and destroy not every living soul. (P. T. Alleluia, alleluia)\n*Ps 79:2*\nGive ear, O Thou that rulest Israel: Thou that leadest Joseph like a sheep.\nGlory be to the Father...\nBe mindful, O Lord, of Thy covenant, and say to the destroying angel. Now hold thy hand, and let not the land be made desolate, and destroy not every living soul. (P. T. Alleluia, alleluia)",
                latin : "*2 Kings 24:16*\nRecordáre, Dómine, testaménti tui, et dic Angelo percutiénti: Cesset jam manus tua, et non desolétur terra, et ne perdas omnem ánimam vivéntem. (T.P. Allelúja, allelúja.)\n*Ps 79:2*\nQui regis Israël, inténde: qui dedúcis, velut ovem, Joseph.\nGlória Patri...\nRecordáre, Dómine, testaménti tui, et dic Angelo percutiénti: Cesset jam manus tua, et non desolétur terra, et ne perdas omnem ánimam vivéntem. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, Who desirest not the death of sinners, but their repentance, look mercifully upon Thy people when they turn unto Thee, that, while they show devotion to Thee, Thou mayst turn away from them the scourges of Thine anger.\nThrough our Lord...",
                latin : "Deus, qui non mortem, sed pœniténtiam desideras peccatórum: pópulum tuum ad te reverténtem propítius réspice; ut, dum tibi devótus exsístit, iracúndiæ tuæ flagélla ab eo cleménter amóveas.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*2 Kings 24:15-19,25*\nIn those days: The Lord sent a pestilence upon Israel, from the morning unto the time appointed, and there died of the people from Dan to Bersabee seventy thousand men. And when the angel of the Lord had stretched out his hand over Jerusalem to destroy it, the Lord had pity on the affliction, and said to the angel that slew the people: It is enough: now hold thy hand. And the angel of the Lord was by the thrashing-floor of Areuna the Jebusite. And David said to the Lord, when he saw the angel striking the people: It is I, I am he that have sinned, I have done wickedly: these that are the sheep, what have they done? Let Thy hand, I beseech Thee, be turned against me, and against my father's house. And Gad came to David that day, and said: Go up, and build an altar to the Lord in the thrashing-floor of Areuna the Jebusite. And David went up according to the word of Gad which the Lord had commanded him: And he built there an altar to the Lord, and offered holocausts and peace offerings: and the Lord became merciful to the land, and the plague was stayed from Israel.",
                latin : "*2 Kings 24:15-19,25*\nIn diébus illis: Immísit Dóminus pestiléntiam in Israël, de mane usque ad tempus constitútum, et mórtui sunt ex pópulo, a Dan usque ad Bersabée, septuagínta mília virórum. Cumque extendísset manum suam Angelus Dómini super Jerúsalem, ut dispérderet eam, misértus est Dóminus super afflictióne, et ait Angelo percutiénti pópulum: Súfficit; nunc cóntine manum tuam. Erat autem Angelus Dómini juxta arcam Aréuna Jebusǽi. Dixít que David ad Dóminum, cum vidísset Angelum cædéntem pópulum: Ego sum, qui peccávi, ego iníque egi: isti, qui oves sunt, quid fecérunt? Vertátur, óbsecro, manus tua contra me et conI tra domum patris mei. Venit autem Gad prophéta ad David in die illa, et dixit ei: Ascénde, et constítue altare Dómino in área Aréuna Jebusǽi. Et ascéndit David juxta sermónem Gad, quem præcéperat ei Dóminus. Et ædificávit altáre Dómino, et óbtulit holocáusta et pacífica: et propitiátus est Dóminus terræ, et cohíbita est plaga ab Israël."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 106:20-21*\nThe Lord sent His word, and healed them: and delivered them from their death. Let the mercies of the Lord give glory to Him; and His wonderful works to the children of men.",
                latin : "*Ps 106:20-21*\nMisit Dóminus verbum suum, et sanávit eos: et erípuit eos de morte eórum. Confiteántur Dómino misericórdiæ ejus: et mirabília ejus fíliis hóminum."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 68:2*\nAlleluia, alleluia. Save me, O God, for the waters are come in even unto my soul. Alleluia.",
                latin : "*Ps 68:2*\nAllelúja, allelúja. Salvum me fac, Deus, quóniam intravérunt aquæ usque ad ánimam meam. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 102:10*\nO Lord, repay us not according to the sins we have committed, nor according to our iniquities.\n*Ps 78:8-9*\nO Lord, remember not our former iniquities: let Thy mercies speedily prevent us, for we are become exceeding poor. Help us, O God our Savior: and for the glory of Thy name, O Lord, deliver us: and forgive us our sins for Thy name's sake.",
                latin : "*Ps 102:10*\nDómine, non secúndum peccáta nostra, quæ fécimus nos: neque secúndum iniquitátes nostras retríbuas nobis.\n*Ps 78:8-9*\nDómine, ne memíneris iniquitátum nostrárum antiquárum: cito antícipent nos misericórdiæ tuæ, quia páuperes facti sumus nimis. Adjuva nos, Deus, salutáris noster: et propter glóriam nóminis tui, Dómine, líbera nos, et propítius esto peccátis nostris, propter nomen tuum."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 68:2*\nAlleluia, alleluia. Save me O God, for the waters are come in even unto my soul. Alleluia.\n*Zach. 8:7,8*\nI will save my people Israel in the evil day: and I will be their God in truth and in justice. Alleluia.",
                latin : "*Ps 68:2*\nAllelúja, allelúja Salvum me fac, Deus, quóniam intravérunt aquæ usque ad ánimam meam. Allelúja.\n*Zach. 8:7,8*\nSalvábo pópulum meum Israël in die malo, et ero eis in Deum, in veritáte et justítia. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Lk 4:38-44*\nAt that time, Jesus rising up out of the synagogue, went into Simon's house: and Simon's wife's mother was taken with a great fever, and they besought Him for her. And standing over her, He commanded the fever, and it left her: and immediately rising, she ministered to them. And when the sun was down, all they that had any sick with divers diseases, brought them to Him: but He laying His hands on every one of them, healed them. And devils went out from many, crying out, and saying, Thou art the Son of God: And rebuking them, He suffered them not to speak, for they knew that He was Christ. And when it was day, going out He went into a desert place; and the multitudes sought Him, and came unto Him; and they stayed Him that He should not depart from them. To whom He said, to other cities also I must preach the kingdom of God, for therefore am I sent. And He was preaching in the synagogues of Galilee.",
                latin : "*Lk 4:38-44*\nIn illo témpore: Surgens Jesus de synagóga, introívit in domum Simónis. Socrus autem Simónis tenebátur magnis fébribus: et rogavérunt illum pro ea. Et stans super illam, imperávit febri: et dimísit illam. Et contínuo surgens, ministrábat illis. Cum autem sol occidísset, omnes, qui habébant infírmos váriis languóribus, ducébant illos ad eum. At ille síngulis manus ímponens, curábat eos. Exíbant autem dæmónia a multis, clamántia et dicéntia: Quia tu es Fílius Dei: et íncrepans non sinébat ea loqui, quia sciébant ipsum esse Christum. Facta autem die egréssus ibat in desértum locum, et turbæ requirébant eum, et venerunt usque ad ipsum: et detinébant illum, ne discéderet ab eis. Quibus ille ait: Quia et aliis civitátibus opórtet me evangelizáre regnum Dei: quia ideo missus sum. Et erat prǽdicans in synagógis Galilǽæ."
            ),
            PropersData (
                title : "Offertory",
                english : "*Num 16:48*\nThe high priest stood between the dead and the living, having a golden censer in his hand: and offering the sacrifice of incense, he appeased the wrath of God, and the affliction from the Lord ceased, (P.T. Alleluia.)",
                latin : "*Num 16:48*\nStetit póntifex inter mórtuos et vivos, habens thuríbulum áureum in manu sua: et ófferens incénsi sacrifícium, placávit iram Dei, et cessávit quassátio a Dómino. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Secret",
                english : "May the offering of the present sacrifice, O Lord, we beseech Thee, assist us, that it may both absolve us from all our sins, and save us from the onslaught of complete destruction.\nThrough our Lord...",
                latin : "Subvéniat nobis, quǽsumus, Dómine, sacrifícii præséntis oblátio: quæ nos et ab erróribus univérsis poténter absolvat, et a totíus erípiat perditiónis incúrsu.\nPer Dóminum nostrum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*Lk 6:17-19*\nA multitude of sick, and they that were troubled with unclean spirits, came to Him: for virtue went out from Him, and healed all. (P. T. Alleluia.)",
                latin : "*Lk 6:17-19*\nMultitúdo languéntium, et qui vexabántur a spirítibus immúndis, veniébant ad eum: quia virtus de illo exíbat, et sanábat omnes. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "Harken unto us, O God, our Savior, and make Thy people free from the terrors of Thy wrath and secure in the gift of Thy mercy.\nThrough our Lord...",
                latin : "Exáudi nos, Deus, salutáris noster: et pópulum tuum ab iracúndiæ tuæ terróribus líberum, et misericórdiæ tuæ fac largitáte secúrum.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    ),
    "In Time of War" : CelebrationData (
        rank : 4,
        title : "In Time of War",
        colors : "v",
        propers : [
            PropersData (
                title : "Introit",
                english : "*Ps 24:6,3,22*\nRemember, O Lord, Thy bowels of compassion, and Thy mercies that are from the beginning of the world, lest at any time our enemies rule over us: deliver us, O God of Israel, from all our tribulations. (P. T. Alleluia, alleluia.)\n*Ps 24:1-2*\nTo Thee, O Lord, have I lifted up my soul: in Thee, O my God. I put my trust; let me not be ashamed.\nGlory be to the Father...\nRemember, O Lord, Thy bowels of compassion, and Thy mercies that are from the beginning of the world, lest at any time our enemies rule over us: deliver us, O God of Israel, from all our tribulations. (P. T. Alleluia, alleluia.)",
                latin : "*Ps 24:6,3,22*\nReminíscere miseratiónum tuarum, Dómine, et misericórdiæ tuæ, quæ a sǽculo sunt: ne umquam dominéntur nobis inimíci nostri: líbera nos, Deus Israël, ex ómnibus angústiis nostris. (T.P. Allelúja, allelúja.)\n*Ps 24:1-2*\nAd te, Dómine, levávi ánimam meam: Deus meus, in te confído, non erubéscam.\nGlória Patri...\nReminíscere miseratiónum tuarum, Dómine, et misericórdiæ tuæ, quæ a sǽculo sunt: ne umquam dominéntur nobis inimíci nostri: líbera nos, Deus Israël, ex ómnibus angústiis nostris. (T.P. Allelúja, allelúja.)"
            ),
            PropersData (
                title : "Collect",
                english : "O God, Who dost stamp out wars and vanquish the assailants of them that hope in Thee, help us when we cry to Thee, that the ferocity of our enemies may be brought low, and we may praise Thee with unceasing thanksgiving.\nThrough our Lord...",
                latin : "Deus, qui cónteris bella, et impugnatóres in te sperántium potentia tuæ defensiónis expúgnas: auxiliáre fámulis tuis, implorántibus misericórdiam tuam; ut, inimicórum suórum feritáte depréssa, incessábili te gratiárum actióne laudémus.\nPer Dóminum nostrum..."
            ),
            PropersData (
                title : "Lesson",
                english : "*Jerm 42:1-2,7-12*\nIn those days all the captains of the warriors came near: and they said to Jeremias the prophet: pray thou for us to the Lord thy God. And the word of the Lord came to Jeremias. And he called all the captains of the fighting men that were with him, and all the people from the least to the greatest. And he said to them: Thus saith the Lord, the God of Israel, to whom you sent me, to present your supplications before Him: If you will be quiet and remain in this land. I will build you up, and not pull you down: I will plant you, and not pluck you up: for now I am appeased for the evil that I have done to you. Fear not because of the king of Babylon, of whom you are greatly afraid: fear him not, saith the Lord: for I am with you, to save you, and to deliver you from his hand. And I will show mercies to you, and will take pity on in you, and will cause you to dwell in your own land, saith the Lord almighty.",
                latin : "*Jerm 42:1-2,7-12*\nIn diébus illis: Accessérunt omnes príncipes bellatórum: dixerúntque ad Jeremíam Prophétam: Ora pro nobis ad Dóminum, Deum tuum. Et factum est verbum Dómini ad Jeremíam. Vocavítque omnes príncipes bellatórum, et univérsum pópulum a mínimo usque ad magnum. Et dixit ad eos: Hæc dicit Dóminus, Deus Israël, ad quem misístis me, ut prostérnerem preces vestras in conspéctu ejus: Si quiescéntes manséritis in terra hac, ædificábo vos, et non déstruam; plantábo, et non evéllam: jam enim placátus sum super malo, quod feci vobis. Nolíte timére a fácie regis Babylónis, quem vos pavídi formidátis; nolíte metúere eum, dicit Dóminus: quia vobíscum sum ego, ut salvos vos fáciam et éruam de manu ejus. Et dabo vobis misericórdias, et miserébor vestri, et habitáre vos fáciam in terra vestra: dicit Dóminus omnípotens."
            ),
            PropersData (
                title : "Gradual",
                english : "*Ps 76:15,16*\nThou art the God that alone that dost wonders: Thou hast made Thy power known among the nations. With Thy arm Thou hast redeemed Thy peopIe, the children of Israel and Joseph.",
                latin : "*Ps 76:15,16*\nTu es Deus, qui facis mirabília solus: notam fecísti in géntibus virtútem tuam. Liberásti in bráchio tuo pópulum tuum, fílios Israël et Joseph."
            ),
            PropersData (
                title : "Lesser Alleluia",
                english : "*Ps 58:2*\nAlleluia, alleluia. Deliver me from my enemies, O my God, and defend me from them that rise up against me. Alleluia.",
                latin : "*Ps 58:2*\nAllelúja, allelúja. Eripe me de inimícis meis, Deus meus: et ab insurgéntibus in me líbera me. Allelúja."
            ),
            PropersData (
                title : "Tract",
                english : "*Ps 102:10*\nO Lord, repay us not according to the sins we have committed, nor according to our iniquities.\n*Ps 78:8-9*\nLord, remember not our former iniquities: let Thy mercies speedily prevent us, for we are become exceeding poor. Help us, O God our Saviour: and for the glory of Thy name, O Lord, deliver us: and forgive us our sins for Thy name's sake.",
                latin : "*Ps 102:10*\nDómine, non secúndum peccáta nostra, quæ fécimus nos: neque secúndum iniquitátes nostras retríbuas nobis.\n*Ps 78:8-9*\nDómine, ne memíneris iniquitátum nostrárum antiquárum: cito antícipent nos misericórdiæ tuæ, quia páuperes facti sumus nimis. Adjuva nos, Deus, salutáris noster: et propter glóriam nóminis tui, Dómine,líbera nos: et propítius esto peccátis nostris, propter nomen tuum."
            ),
            PropersData (
                title : "Greater Alleluia",
                english : "*Ps 58:2,17*\nAlleluia, alleluia. Deliver me from my enemies, O my God: and defend me from them that rise up against me. Alleluia. But I will sing Thy strength: and will extol Thy mercy in the morning. Alleluia.",
                latin : "*Ps 58:2,17*\nAllelúja, allelúja. Eripe me de inimícis meis, Deus meus: et ab insurgéntibus in me líbera me. Allelúja. Ego autem cantábo fortitúdinem tuam: et exsultábo mane misericórdiam tuam. Allelúja."
            ),
            PropersData (
                title : "Gospel",
                english : "*Matt 24:3-8*\nAt that time: The disciples came to Jesus privately, saying, Tell us, when shall these things be? and what shall be the sign of Thy coming, and of the consummation of the world? And Jesus answering, said to them: Take heed that no man seduce you: For many will come in My name saying, I am Christ: and they will seduce many. And you shall hear of wars, and rumors of wars. see that ye be not troubled. For these things must come to pass, but the end is not yet. For nation shall rise against nation, and kingdom against kingdom; and there shall be pestilences, and famines, and earthquakes in places: Now all these are the beginning of sorrows.",
                latin : "*Matt 24:3-8*\nIn illo témpore: Accessérunt ad Jesum discípuli secréto, dicéntes: Dic nobis, quando hæc erunt? et quod signum advéntus tui et consummatiónis sǽculi? Et respóndens Jesus, dixit eis: Vidéte, ne quis vos sedúcat. Multi enim vénient in nómine meo, dicéntes: Ego sum Christus; et multos sedúcent. Auditúri enim estis prǿlia et opiniónes prœliórum. Vidéte, ne turbémini. Opórtet enim hæc fíeri, sed nondum est finis. Consúrget enim gens in gentem, et regnum in regnum, et erunt pestiléntiæ et fames et terræmótus per loca. Hæc autem ómnia, inítia sunt dolórum."
            ),
            PropersData (
                title : "Offertory",
                english : "*Ps 17:28,32*\nThou wilt save the humble people, O Lord, and wilt bring down the eyes of the proud; for Who is God but Thee, O Lord? (P. T. Alleluia.)",
                latin : "*Ps 17:28,32*\nPópulum húmilem salvum fácies, Dómine, et óculos superbórum humiliábis: quóniam quis Deus præter te, Dómine? (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Secret",
                english : "Be appeased, O Lord, by the sacrifice which we offer, that it may deliver us from all the evil of war and set us in the security of Thy protection.\nThrough our Lord...",
                latin : "Sacrifícium, Dómine, quod immolámus, inténde placátus: ut ab omni nos éruat bellórum nequítia, et in tuæ protectiónis securitáte constítuat.\nPer Dóminum nostrum..."
            ),
            PropersData ( title: "Preface of the Season", english: "", latin: "" ),
            PropersData (
                title : "Communion",
                english : "*Ps 30:3*\nBow down Thy ear, make haste to deliver us. (P. T. Alleluia.)",
                latin : "*Ps 30:3*\nInclína aurem tuam: accélera, ut erípias nos. (T.P. Allelúja.)"
            ),
            PropersData (
                title : "Postcommunion",
                english : "O God, Who hast dominion over all kingdoms and all kings, Who dost both heal us by smiting and preserve us by pardoning, stretch forth Thy mercy toward us, that we may employ for the uses of correction the tranquility and peace secured by Thy power.\nThrough our Lord...",
                latin : "Deus, regnórum ómnium regúmque dominátor, qui nos et percutiéndo sanas et ignoscéndo consérvas: præténde nobis misericórdiam tuam; ut tranquillitáte pacis, tua potestáte serváta, ad remédia correctiónis utámur.\nPer Dóminum nostrum..."
            )
        ],
        commemorations : []
    )
]
