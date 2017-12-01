Documenting your programs with a poor mans Jupiter notebook, knitr or SASweave;

for output see
https://goo.gl/9mCeaj
https://github.com/rogerjdeangelis/utl_documenting_your_programs_with_a_poor_mans_knitr_or_sasweave/blob/master/utl_documenting_your_programs_with_a_poor_mans_knitr_or_sasweave.pdf

/*
   This code supports pdf and ppt output. Also supports integrating
   R and Python. Existing pdf pages can be appended or inserted.
   Powerpoint themes can be added.
*/

INPUT
=====

  All input is imbedded in the script


WORKING CODE
===========

    * Title Page;
    %Tut_Sly
       (
        stop=13
        ,L13 ='^S={font_size=35pt just=c &w}Poor Mans SAS Weave'
        ,L15 ='^S={font_size=35pt just=c &w}Documenting your programs'
       );

    * christmass tree code title slide;;
    %Tut_Sly
       (
        stop=5
        ,L5 ='^S={font_size=25pt just=c &w}Code and Christmas Tree Graph'
       );


    * code is written to the pdf file and executed with all output to pdf file;
    %codebegin cards4;

    data xmastree;
    r=4; h=11.25;
    a=arsin(r/(r**2+h**2)**.5);
    do y=-r to r by .02;
      do x=-r to r by .02;
        z=h-(x**2+y**2)**.5/sin(a)*cos(a);
        if (x**2+y**2)**.5>4 or 1.25<z<2 or 3.25<z<4
        or 5.25<z<6 or 7.25<z<8 or 9.25<z<10 then z=.;
        output;
      end;
    end;
    run;quit;
    ...

    proc sgrender data=xmastree template=xmastree;
    run;quit;

    ;;;;
    run;quit;


    * roses tile slide
    %Tut_Sly
       (
        stop=5
        ,L5 ='^S={font_size=25pt just=c &w}Code and Polar Roses Graph'
       );

    * code written to pdf and executed;
    %codebegin cards4;
    %macro makecard(for=Mary,from=Joe);
          data Roses;
                array klist{11} _temporary_
                (4, 5, 6, 1.5, 2.5, 1.333333, 2.33333, .75, 1.25, 1.2, .8333333);
                do flower=1 to 12;
                      n = ceil( 11*rand("Uniform") );
                      /*pick a random number between 1 and 11*/
                      k=klist{n}; /*assign k to be the nth multiplier*/
                      /* draw the rose r=cos(k * theta) */
                      do theta = 0 to 12*constant("pi") by 0.1;
                            r = cos(k * theta);      /* generalized rose */
                            x = r*cos(theta);        /* convert to Euclidean coords */
                            y = r*sin(theta);
                            /*move the rose to the right spot*/
                      end;
                end;
                /*bow*/
          run;quit;
          ....
          proc sgplot data=Roses aspect=1 noautolegend
                      noborder nowall;
                styleattrs datacontrastcolors=
                      (
                      green green green green
                      green green green green
                      green green green green
                      red  bippk red purple bippk
                      blue purple  bippk red purple  blue red
                      crimson
                            ) datalinepatterns=(1);
                series x=x y=y /group=group;
                xaxis min=0 max=15 display=none;
                yaxis min=0 max=15 display=none;
                /*footnote "Lots of Love, &from";*/
                footnote6 " Generated with the SAS System 9.4";
                footnote7 "initial idea: http://blogs.sas.com/content/iml/2015/12/16/polar-rose.html";
          run;quit;
          title;
          footnote;
    %mend;
    %makecard(for=Mary ,from=Joe);

    ;;;;
    run;quit;

    * simple proc report title slide;
    %Tut_Sly
       (
        stop=5
        ,L5 ='^S={font_size=25pt just=c &w}Simple proc report'
       );

    %codebegin cards4;
    proc report data=sashelp.class;
    cols name age sex height weight _row;
    %greenbar;
    run;quit;
    ;;;;
    run;quit;

OUTPUT
=====

https://goo.gl/9mCeaj
https://github.com/rogerjdeangelis/utl_documenting_your_programs_with_a_poor_mans_knitr_or_sasweave/blob/master/utl_documenting_your_programs_with_a_poor_mans_knitr_or_sasweave.pdf

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%let pdf2ppt=c:\exe\p2p\pdftopptcmd.exe;  * free boxoft pdf to ppt converter;

%let wevoutpdf=d:\pdf\&pgm..pdf;          * output pdf;
%let wevoutppt=d:\ppt\&pgm..ppt;          * free boxoft will convert this output to appt;

******************************************************************************;

proc datasets library=work kill;
run;quit;;

%Macro utl_ymrlan100
    (
      style=utl_ymrlan100
      ,frame=box
      ,TitleFont=13pt
      ,docfont=13pt
      ,fixedfont=12pt
      ,rules=ALL
      ,bottommargin=.25in
      ,topmargin=.25in
      ,rightmargin=.25in
      ,leftmargin=.25in
      ,cellheight=13pt
      ,cellpadding = .2pt
      ,cellspacing = .2pt
      ,borderwidth = .2pt
    ) /  Des="SAS PDF Template for PDF";

ods path work.templat(update) sasuser.templat(update) sashelp.tmplmst(read);

proc template ;
source styles.printer;
run;quit;

Proc Template;

   define style &Style;
   parent=styles.rtf;

        class body from Document /

               protectspecialchars=off
               asis=on
               bottommargin=&bottommargin
               topmargin   =&topmargin
               rightmargin =&rightmargin
               leftmargin  =&leftmargin
               ;

        class color_list /
              'link' = blue
               'bgH'  = _undef_
               'fg'  = black
               'bg'   = _undef_;

        class fonts /
               'TitleFont2'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'TitleFont'            = ("Arial, Helvetica, Helv",&titlefont,Bold)

               'HeadingFont'          = ("Arial, Helvetica, Helv",&titlefont)
               'HeadingEmphasisFont'  = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'StrongFont'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'EmphasisFont'         = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'FixedFont'            = ("Courier New, Courier",&fixedfont)
               'FixedEmphasisFont'    = ("Courier New, Courier",&fixedfont,Italic)
               'FixedStrongFont'      = ("Courier New, Courier",&fixedfont,Bold)
               'FixedHeadingFont'     = ("Courier New, Courier",&fixedfont,Bold)
               'BatchFixedFont'       = ("Courier New, Courier",&fixedfont)

               'docFont'              = ("Arial, Helvetica, Helv",&docfont)

               'FootFont'             = ("Arial, Helvetica, Helv", 9pt)
               'StrongFootFont'       = ("Arial, Helvetica, Helv",8pt,Bold)
               'EmphasisFootFont'     = ("Arial, Helvetica, Helv",8pt,Italic)
               'FixedFootFont'        = ("Courier New, Courier",8pt)
               'FixedEmphasisFootFont'= ("Courier New, Courier",8pt,Italic)
               'FixedStrongFootFont'  = ("Courier New, Courier",7pt,Bold);

        class GraphFonts /
               'GraphDataFont'        = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphValueFont'       = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphLabelFont'       = ("Arial, Helvetica, Helv",&fixedfont,Bold)
               'GraphFootnoteFont'    = ("Arial, Helvetica, Helv",8pt)
               'GraphTitleFont'       = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'GraphAnnoFont'        = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphUnicodeFont'     = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphLabel2Font'      = ("Arial, Helvetica, Helv",&fixedfont)
               'GraphTitle1Font'      = ("Arial, Helvetica, Helv",&fixedfont)
               'NodeDetailFont'       = ("Arial, Helvetica, Helv",&fixedfont)
               'NodeInputLabelFont'   = ("Arial, Helvetica, Helv",&fixedfont)
               'NodeLabelFont'        = ("Arial, Helvetica, Helv",&fixedfont)
               'NodeTitleFont'        = ("Arial, Helvetica, Helv",&fixedfont);


        style Graph from Output/
                outputwidth = 100% ;

        style table from table /
                outputwidth=100%
                protectspecialchars=off
                asis=on
                background = colors('tablebg')
                frame=&frame
                rules=&rules
                cellheight  = &cellheight
                cellpadding = &cellpadding
                cellspacing = &cellspacing
                bordercolor = colors('tableborder')
                borderwidth = &borderwidth;

         class Footer from HeadersAndFooters

                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off ;

                class FooterFixed from Footer
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                class FooterEmpty from Footer
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                class FooterEmphasis from Footer
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                class FooterEmphasisFixed from FooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                class FooterStrong from Footer
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                class FooterStrongFixed from FooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                class RowFooter from Footer
                / font = fonts('FootFont')  asis=on protectspecialchars=off just=left;

                class RowFooterFixed from RowFooter
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                class RowFooterEmpty from RowFooter
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                class RowFooterEmphasis from RowFooter
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                class RowFooterEmphasisFixed from RowFooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                class RowFooterStrong from RowFooter
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                class RowFooterStrongFixed from RowFooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                class SystemFooter from TitlesAndFooters / asis=on
                        protectspecialchars=off just=left;
    end;
run;
quit;

%Mend utl_ymrlan100;
%utl_ymrlan100;

%Macro Tut_Sly
(
 stop=43,
 L1=' ',  L43=' ',  L2=' ', L3=' ', L4=' ', L5=' ', L6=' ', L7=' ', L8=' ', L9=' ',
 L10=' ', L11=' ',
 L12=' ', L13=' ', L14=' ', L15=' ', L16=' ', L17=' ', L18=' ', L19=' ',
 L20=' ', L21=' ',
 L22=' ', L23=' ', L24=' ', L25=' ', L26=' ', L27=' ', L28=' ', L29=' ', L30=' ', L31=' ', L32=' ',
 L33=' ', L34=' ', L35=' ', L36=' ', L37=' ', L38=' ', L39=' ', L40=' ', L41=' ', L42=' ',
 L44=' ', L45=' ', L46=' ', L47=' ', L48=' ', L49=' ', L50=' ', L51=' ', L52=' '
 )/ des="SAS Slides all argument values need to be single quoted";

/* creating slides for a presentation */
/* up to 32 lines */
/* backtic ` is converted to a single quote  */
/* | is converted to a , */

Data _OneLyn1st(rename=t=title);

Length t $255;
 t=resolve(translate(&L1,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L2,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L3,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L4,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L5,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L6,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L7,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L8,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
 t=resolve(translate(&L9,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L10,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L11,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L12,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L13,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L14,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L15,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L16,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L17,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L18,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L19,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L20,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L21,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L22,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L23,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L24,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L25,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L26,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L27,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L28,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L29,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L30,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L31,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L32,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L33,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L34,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L35,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L36,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L37,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L38,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L39,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L41,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L42,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L43,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L44,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L45,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L46,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L47,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L48,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L50,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L51,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;
t=resolve(translate(&L52,"'","`"));t=translate(t,",","|");t=translate(t,";","~");t=translate(t,'%',"#");t=translate(t,'&',"@");Output;

run;quit;

/*  %let l7='^S={font_size=25pt just=c cellwidth=100pct}Premium Dollars';  */

options label;
%if &stop=7 %then %do;
   data _null_;
      tyt=scan(&l7,2,'}');
      call symputx("tyt",tyt);
   run;
   ods pdf bookmarkgen=on bookmarklist=show;
   ods proclabel="&tyt";run;quit;
%end;
%else %do;
   ods proclabel="Title";run;quit;
%end;


data _onelyn;
  set _onelyn1st(obs=%eval(&stop + 1));
  if not (left(title) =:  '^') then do;
     pre=upcase(scan(left(title),1,' '));
     idx=index(left(title),' ');
     title=substr(title,idx+1);
  end;
  put title;
run;

* display the slide ;
title;
footnote;

proc report data=_OneLyn nowd  style=utl_pdflan100;
col title;
define title / display ' ';
run;
quit;

%Mend Tut_Sly;


%macro utl_boxpdf2ppt(inp=&outpdf001,out=&outppt001)/des="www.boxoft.con pdf to ppt";
  data _null_;
    cmd=catt("&pdf2ppt",' "',"&inp", '"',' "',"&out",'"');
    put cmd;
    call system(cmd);
  run;
%mend utl_boxpdf2ppt;

%MACRO greenbar ;
   DEFINE _row / order COMPUTED NOPRINT ;
   COMPUTE _row;
      nobs+1;
      _row = nobs;
      IF (MOD( _row,2 )=0) THEN
         CALL DEFINE( _ROW_,'STYLE',"STYLE={BACKGROUND=graydd}" );
   ENDCOMP;
%MEND greenbar;


%macro pdfbeg(rules=all,frame=box);
    %utlnopts;
    options orientation=landscape validvarname=v7;
    ods listing close;
    ods pdf close;
    ods path work.templat(update) sasuser.templat(update) sashelp.tmplmst(read);
    %utlfkil(&wevoutpdf..pdf);
    ods noptitle;
    ods escapechar='^';
    ods listing close;
    ods graphics on / width=10in  height=7in ;
    ods pdf file="&wevoutpdf"
    style=utl_ymrlan100 notoc /* bookmarkgen=on bookmarklist=show */;
%mend pdfbeg;

%macro codebegin;
  options orientation=landscape lrecl=384;
  data _null_;
  length lyn $384;
   input;
   lyn=strip(_infile_);
   file print;
   put lyn "^{newline}" @;
   call execute(_infile_);
%mend codebegin;


%macro pdfend;
   ods graphics off;
   ods pdf close;
   ods listing;
   %utlopts;
%mend pdfend;

 ***   *****    *    ****   *****
*   *    *     * *   *   *    *
 *       *    *   *  *   *    *
  *      *    *****  ****     *
   *     *    *   *  * *      *
*   *    *    *   *  *  *     *
 ***     *    *   *  *   *    *;


%pdfbeg;

* common slide properties;
%let z=%str(                  );
%let b=%str(font_weight=bold);
%let c=%str(font=("Courier New"));
%let w=%str(cellwidth=100pct);

/*
* because I allow macro triggers
use these when you do not want a trigger.
Use double quotes when possible
| to ,
` to single quote
~ to semi colon
# to percent sign
@ to ambersand
*/

title;
footnote;

/* https://communities.sas.com/t5/SAS-GRAPH-and-ODS-Graphics/O-DS-Christmas-Tree/m-p/240189 */

* first slide;
%Tut_Sly
   (
    stop=13
    ,L13 ='^S={font_size=35pt just=c &w}Poor Mans SAS Weave'
    ,L15 ='^S={font_size=35pt just=c &w}Documenting your programs'
   );

%Tut_Sly
   (
    stop=5
    ,L5 ='^S={font_size=25pt just=c &w}Code and Christmas Tree Graph'
   );

%codebegin cards4;

data xmastree;
r=4; h=11.25;
a=arsin(r/(r**2+h**2)**.5);
do y=-r to r by .02;
  do x=-r to r by .02;
    z=h-(x**2+y**2)**.5/sin(a)*cos(a);
    if (x**2+y**2)**.5>4 or 1.25<z<2 or 3.25<z<4
    or 5.25<z<6 or 7.25<z<8 or 9.25<z<10 then z=.;
    output;
  end;
end;
run;quit;

proc template;
define statgraph xmastree;
begingraph;
drawtext textattrs=(size=50pt COLOR=gold FAMILY="Arial Unicode MS")
         {unicode '2605'x} /
         anchor=topleft widthunit=percent x=46.5 y=99 justify=center ;
layout overlay3d / cube=false;
surfaceplotparm x=x y=y z=z / fillattrs=(color=forestgreen);
endlayout;
endgraph;
end;
run;quit;

proc sgrender data=xmastree template=xmastree;
run;quit;

;;;;
run;quit;

%Tut_Sly
   (
    stop=5
    ,L5 ='^S={font_size=25pt just=c &w}Code and Polar Roses Graph'
   );

%codebegin cards4;
%macro makecard(for=Mary,from=Joe);
      data Roses;
            array klist{11} _temporary_
            (4, 5, 6, 1.5, 2.5, 1.333333, 2.33333, .75, 1.25, 1.2, .8333333);
            do flower=1 to 12;
                  n = ceil( 11*rand("Uniform") );
                  /*pick a random number between 1 and 11*/
                  k=klist{n}; /*assign k to be the nth multiplier*/
                  /* draw the rose r=cos(k * theta) */
                  do theta = 0 to 12*constant("pi") by 0.1;
                        r = cos(k * theta);      /* generalized rose */
                        x = r*cos(theta);        /* convert to Euclidean coords */
                        y = r*sin(theta);
                        /*move the rose to the right spot*/
                        if flower <= 5 then
                              do;
                                    cx=2*flower+1;
                                    cy=9;
                              end;
                        else if 6<= flower<=9 then
                              do;
                                    cx=(2*flower-8);
                                    cy=10.5;
                              end;
                        else if 10<= flower<=12 then
                              do;
                                    cx=(2*flower-15);
                                    cy=12;
                              end;
                        x=x+cx;
                        y=y+cy;
                        group=flower;
                        output;
                        /*make the stem*/
                        group=-flower;
                        x=cx;
                        y=cy;
                        output;
                        x=7;
                        y=3;
                        output;
                  end;
            end;
            /*bow*/
            do theta = constant("pi")*7.5/12 to constant("pi")*28.5/12 by 0.01;
                  r = cos(2 * (theta));       /* rose */
                  x = r*cos(theta);          /* convert to Euclidean coords */
                  y = r*sin(theta);
                  group=100;
                  if y<abs(x) then
                        do;
                              x=x+7;
                              y=y+3;
                              output;
                        end;
            end;
      run;quit;
      proc sort data=roses;
            by group;
            title1 "Happy Valentines Day" ;
            title2 "A Dozen Random Polar Roses" ;
      run;quit;
      proc sgplot data=Roses aspect=1 noautolegend
                  noborder nowall;
            styleattrs datacontrastcolors=
                  (
                  green green green green
                  green green green green
                  green green green green
                  red  bippk red purple bippk
                  blue purple  bippk red purple  blue red
                  crimson
                        ) datalinepatterns=(1);
            series x=x y=y /group=group;
            xaxis min=0 max=15 display=none;
            yaxis min=0 max=15 display=none;
            /*footnote "Lots of Love, &from";*/
            footnote1 " ";
            footnote3 " ";
            footnote4 " ";
            footnote5 " Polar Roses: r = cos(k*theta)";
            footnote6 " Generated with the SAS System 9.4";
            footnote7 "initial idea: http://blogs.sas.com/content/iml/2015/12/16/polar-rose.html";
      run;quit;
      title;
      footnote;
%mend;
%makecard(for=Mary ,from=Joe);

;;;;
run;quit;

%Tut_Sly
   (
    stop=5
    ,L5 ='^S={font_size=25pt just=c &w}Simple proc report'
   );

%codebegin cards4;
proc report data=sashelp.class;
cols name age sex height weight _row;
%greenbar;
run;quit;
;;;;
run;quit;

%pdfend;


