baseURL = 'http://localhost:8081'
describe('Page navigation', () => {

  it('Navigates to home', () => {
    cy.visit(baseURL)
    cy.url().should('eq', baseURL + '/#/')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates to posts', () => {
    cy.visit(baseURL + '/#/posts')
    cy.url().should('eq', baseURL + '/#/posts')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates to new posts', () => {
    cy.visit(baseURL + '/#/posts/new')
    cy.url().should('eq', baseURL + '/#/posts/new')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates to media', () => {
    cy.visit(baseURL + '/#/media')
    cy.url().should('eq', baseURL + '/#/media')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates to pages', () => {
    cy.visit(baseURL + '/#/pages')
    cy.url().should('eq', baseURL + '/#/pages')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates to settings', () => {
    cy.visit(baseURL + '/#/settings')
    cy.url().should('eq', baseURL + '/#/settings')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates to about', () => {
    cy.visit(baseURL + '/#/about')
    cy.url().should('eq', baseURL + '/#/about')
    cy.get('.home').should('not.contain', '404 Page Not Found');
  })

  it('Navigates between all pages', () => {
    cy.visit(baseURL)
    cy.url().should('eq', baseURL + '/#/')
    cy.get('.home').should('not.contain', '404 Page Not Found');
    cy.contains('Posts')
    cy.contains('Posts').click()
    cy.url().should('eq', baseURL + '/#/posts')
    cy.get('.home').should('not.contain', '404');
    cy.contains('New Post')
    cy.contains('New Post').click()
    cy.url().should('eq', baseURL + '/#/posts/new')
    cy.get('.home').should('not.contain', '404');
    cy.contains('Media')
    cy.contains('Media').click()
    cy.url().should('eq', baseURL + '/#/media')
    cy.get('.home').should('not.contain', '404');
    cy.contains('Pages')
    cy.contains('Pages').click()
    cy.url().should('eq', baseURL + '/#/pages')
    cy.get('.home').should('not.contain', '404');
    cy.contains('Settings')
    cy.contains('Settings').click()
    cy.url().should('eq', baseURL + '/#/settings')
    cy.get('.home').should('not.contain', '404');
    cy.contains('About')
    cy.contains('About').click()
    cy.url().should('eq', baseURL + '/#/about')
    cy.get('.home').should('not.contain', '404');
  })
})